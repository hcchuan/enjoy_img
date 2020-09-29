<?php
/**转换数组格式，如：[{"id":1,"name":"可用"},{"id":2,"name":"不可用"}]转换为[1=>"可用",2=>"不可用"]
 *
 */
function GetEasyArr($list)
{
    if(!is_array($list))
    {
        $list=json_decode($list,true);
    }
    $arr=[];
    if(empty($list)||!is_array($list))
    {
        return $arr;
    }
    foreach ($list as $key=>$val)
    {
        $arr[$val['id']]=$val['name'];
    }
    return $arr;
}

/**转换数组格式，如：将[1=>"可用",2=>"不可用"]转换为[{"id":1,"name":"可用"},{"id":2,"name":"不可用"}]
 *
 */
function GetCommonArr($list)
{
    $arr=[];
    if(empty($list)||!is_array($list))
    {
        return $arr;
    }
    foreach ($list as $key=>$val)
    {
        if(empty($key))
        {
            continue;
        }
        $arr[]=array('id'=>$key,'name'=>$val);
    }
    return $arr;
}
/**根据时间类型获取时间段
 * @param  time_type时间类型：0全部、1今日、2本周、3本月、4本年、5近一周、6近一月、7近一年、8自定义时间段、9本季度、10本半年，不传默认为0
 * @param  begin_time开始时间，格式如 '2020-01-01'，只有time_type为8时才有效
 * @param  end_time结束时间，格式如 '2020-09-01'，只有time_type为8时才有效
 * @param attach_time返回值是否带时间
 * @return array
 * 带时间返回格式如["2020-03-01 00:00:00","2020-03-31 23:59:59"]
 * 不带时间返回格式如["2020-03-01","2020-03-31"]
 */
function get_date_range($time_type = 0, $begin_time = '', $end_time = '', $attach_time = false)
{
    $min_date = date('Y-m-d', strtotime('-1 year'));
    $date_range = [$min_date, date('Y-m-d')];
    switch ($time_type) {
        case 1:
            $date_range = [date('Y-m-d'), date('Y-m-d')];
            break;
        case 2:
            $date_range = get_week_range();
            break;
        case 3:
            $date_range = get_month_range();
            break;
        case 4:
            $date_range = get_year_range();
            break;
        case 5:
            $date_range = get_recently_time('', 1);
            break;
        case 6:
            $date_range = get_recently_time('', 2);
            break;
        case 7:
            $date_range = get_recently_time('', 5);
            break;
        case 8://自定义时间段----C('MIN_DATE')和C('MAX_DATE')是默认最小，最大时间，使用时修改为自己的
            $begin_time = !empty($begin_time) ? $begin_time : C('MIN_DATE');
            $end_time = !empty($end_time) ? $end_time : C('MAX_DATE');
            $date_range = [$begin_time, $end_time];
            break;
        case 9://本季度
            $month=date('n');
            $quarter=($month%3!=0)?intval($month/3)+1:intval($month/3);//季度

            $begin_month=($quarter-1)*3+1;//本季度第一个月
            $begin_month_next=$begin_month+3;//下季度第一个月
            //exit(($month%3).'--'.intval($month/3).'--'.$quarter.'--'.$begin_month.'--'.$begin_month_next);
            $begin_month= sprintf('%02s', $begin_month);//以0补全，共2位
            $begin_month_next= sprintf('%02s', $begin_month_next);//以0补全，共2位

            $begin_time=date('Y-'.$begin_month.'-01');//本季度第一天
            //本季度最后一天
            $end_time=date('Y-m-d',strtotime("-1 days",strtotime(date('Y-'.$begin_month_next.'-01'))));

            $date_range = [$begin_time, $end_time];
            break;
        case 10://本半年
            if(date('n')<=6)
            {
                $begin_time=date('Y-01-01');//本半年第一天
                $end_time=date('Y-06-30');//本半年第一天
            }
            else
            {
                $begin_time=date('Y-07-01');//本半年第一天
                $end_time=date('Y-12-31');//本半年第一天
            }
            $date_range = [$begin_time, $end_time];
            break;
    }
    if ($attach_time) {
        $date_range[0] = $date_range[0] . ' 00:00:00';
        $date_range[1] = $date_range[1] . ' 23:59:59';
    }
    return $date_range;
}

/**(本周)取指定日期所在周的第一天和最后一天
 * @param day#某天，格式如2019-11-01，不传默认为当日
 * @param attach_time#返回值是否带时间(默认带时间)
 * @return array
 * 带时间返回["2020-03-01 00:00:00","2020-03-31 23:59:59"]
 * 不带时间返回["2020-03-01","2020-03-31"]
 */
function get_week_range($day='',$attach_time=false)
{
    if(empty($day))
    {
        $day = date('Y-m-d');
    }
    $time=strtotime($day);
    $week_day=date('w');
    if($week_day==0)
    {
        $week_day=7;
    }
    $start_time=date('Y-m-d',strtotime('-'.($week_day-1).' day',$time));
    $end_time=date('Y-m-d',strtotime('+'.(7-$week_day).' day',$time));

    if($attach_time)
    {
        $start_time = $start_time.' 00:00:00';
        $end_time = $end_time.' 23:59:59';
    }

    return [$start_time,$end_time];
}

/**获取指定年份第一天和最后一天（不指定则默认为当年）
 * @param attach_time#返回值是否带时间(默认带时间)
 * @return array
 * 带时间返回["2020-01-01 00:00:00","2020-12-31 23:59:59"]
 * 不带时间返回["2020-01-01","2020-12-31"]
 */
function get_year_range($year='',$attach_time=false)
{
    if(empty($year))
    {
        $year=date('Y');
    }
    $start_time=$year.'-01-01';
    $end_time=$year.'-12-31';
    if($attach_time)
    {
        $start_time = $start_time.' 00:00:00';
        $end_time = $end_time.' 23:59:59';
    }
    return [$start_time,$end_time];
}

/**获取指定月份第一天和最后一天（不指定则默认为当前月）
 * @param attach_time#返回值是否带时间(默认带时间)
 * @return array
 * 带时间返回["2020-03-01 00:00:00","2020-03-31 23:59:59"]
 * 不带时间返回["2020-03-01","2020-03-31"]
 */
function get_month_range($month='',$attach_time=false)
{
    if(empty($month))
    {
        $month=date('Y-m');
    }
    $start_time=$month.'-01';//本月的第一天，格式如2015-01-01
    $end_time=date($month.'-d',strtotime("$start_time +1 month -1 day"));
    if($attach_time)
    {
        $start_time = $start_time.' 00:00:00';
        $end_time = $end_time.' 23:59:59';
    }
    return [$start_time,$end_time];
}

/**(取最近时间范围)取指定日期所在近一周、近一月、近三月、近半年、近一年的第一天和最后一天
 * @param day某天，格式如2019-11-01，不传默认为当日
 * @param time_type日期类型：1近一周、2近一月、3近三月、4近半年、5近一年
 * @param attach_time返回值是否带时间(默认带时间)
 * @return array
 * 带时间返回["2020-03-01 00:00:00","2020-03-31 23:59:59"]
 * 不带时间返回["2020-03-01","2020-03-31"]
 */
function get_recently_time($day='',$time_type,$attach_time=false)
{
    if(empty($time_type))
    {
        return [];
    }
    if(empty($day))
    {
        $day = date('Y-m-d');
    }

    $time=strtotime($day);
    $day_diff='-0 day';
    switch ($time_type)
    {
        case 1:$day_diff = '-7 day';break;
        case 2:$day_diff = '-1 month';break;
        case 3:$day_diff = '-3 month';break;
        case 4:$day_diff = '-6 month';break;
        case 5:$day_diff = '-1 year';break;
    }
    $start_time=date('Y-m-d',strtotime($day_diff,$time));
    $end_time=$day;

    if($attach_time)
    {
        $start_time = $start_time.' 00:00:00';
        $end_time = $end_time.' 23:59:59';
    }
    return [$start_time,$end_time];
}