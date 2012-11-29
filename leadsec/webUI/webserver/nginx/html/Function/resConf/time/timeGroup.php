<?php
    require_once($_SERVER['DOCUMENT_ROOT'] . '/Function/common.php');

    function getTimeGroupData() {
        $result = array();
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT name, subname FROM time_grp where subname NOT LIKE '%\_mon' ESCAPE '\' AND ".
            "subname NOT LIKE '%\_tue' ESCAPE '\' AND subname NOT LIKE '%\_wed' ESCAPE '\' AND ".
            "subname NOT LIKE '%\_thu' ESCAPE '\' AND subname NOT LIKE '%\_fri' ESCAPE '\' AND ".
            "subname NOT LIKE '%\_sat' ESCAPE '\' AND subname NOT LIKE '%\_sun' ESCAPE '\'";
        $data   = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        foreach ($data as $d) {
            $result[$d['name']]['subname'][] = $d['subname'];
            if (empty($result[$d['name']]['comment'])) {
                $result[$d['name']]['comment'] = getSpecComment($d['name']); 
            }
        }
        return $result;
    }

    function getSpecComment($name) {
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT comment FROM grp_comment WHERE name = '$name'";
        $data = $db->query($sql)->getFirstData(PDO::FETCH_ASSOC);
        return $data['comment'];
    }

    function freshTimeGroup() {
        $tpl  = 'resConf/time/timeGroupTable.tpl';
        $data = getTimeGroupData();
        echo V::getInstance()->assign('timeGroup', $data)
            ->fetch($tpl);
    }

    function getAllTimeList() {
        $tpl  = 'resConf/time/timeListTable.tpl';
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT name FROM time_span";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        $weekName = array('mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun');
        foreach ($data as $v) {
            $pos = strrpos($v['name'], '_');
            if ($pos !== false) {
                $nameSuffix = substr($v['name'], $pos+1);
                if (false !== array_search($nameSuffix, $weekName)) {
                    $name = substr($v['name'], 0, -($pos-1));
                    $result[$name] = true;
                } else {
                    $result[$v['name']] = true;
                }
            } else {
                $result[$v['name']] = true;
            }
        }
        return array_keys($result);
    }

    function getTimeListBySpecGrp($name) {
        $db   = new dbsqlite('/usr/local/tss/conf/db_hss_tss');
        $sql  = "SELECT subname FROM time_grp WHERE name = '$name'";
        $data = $db->query($sql)->getAllData(PDO::FETCH_ASSOC);
        $result = array();
        foreach ($data as $d) {
            $result[] = $d['subname'];
        }
        return $result;
    }

    if ($name = $_POST['name']) {
        // Get specified time group data
        $tpl = $_POST['tpl'];
        $data['name']    = $name;
        $data['comment'] = getSpecComment($name);
        $allTimeList = getAllTimeList();
        $specMbr = getTimeListBySpecGrp($name);
        $specTL = array_diff($allTimeList, $specMbr);
        $result = V::getInstance()->assign('timeGroup', $data)
            ->assign('timeGroupArr', $specTL)
            ->assign('timeGrpMemberArr', $specMbr)
            ->assign('type', 'edit')->fetch($tpl);
        echo json_encode(array('msg' => $result));
    } else if ('add' === $_POST['type']) {
        // Add new time group data
        $name    = $_POST['timeGroupName'];
        $addmbr  = $_POST['timeGrpMember'];
        $comment = $_POST['comment'];

        $cli = new cli();
        $cmd = "timegrp add name \"$name\" comment \"$comment\"";
        $cli->run($cmd);
        foreach ($addmbr as $m) {
            $cmd = "timegrp set name \"$name\" addmbr \"$addmbr\"";
            $cli->run($cmd);
        }
        echo json_encode(array('msg' => '添加成功.'));
    } else if ('edit' === $_POST['type']) {
        // Edit the specified time group data
        $name    = $_POST['timeGroupName'];
        $addmbr  = $_POST['timeGrpMember'];
        $comment = $_POST['comment'];

        $cli = new cli();
        $cmd = "timegrp set name \"$name\" delallmbr";
        $cli->run($cmd1);
        $cmd = "timegrp set name \"$name\" comment \"$comment\"";
        $cli->run($cmd);
        foreach ($addmbr as $m) {
            $cmd = "timegrp set name \"$name\" addmbr \"$addmbr\"";
            $cli->run($cmd);
        }
        echo json_encode(array('msg' => '修改成功.'));
    } else if ($name = $_POST['delName']) {
        // Delete the specified time group data
        $cmd  = "timegrp del name \"$name\"";
        $cli  = new cli();
        $cli->run($cmd);
        echo json_encode(array('msg' => "[$name]删除成功."));
    } else if (!empty($_POST['openNewTimeGrpDialog'])) {
        // Display add time group dialog
        $tpl = $_POST['tpl'];
        $timeGroupArr = getAllTimeList();
        $result = V::getInstance()->assign('timeGroupArr', $timeGroupArr)
            ->assign('timeGrpMemberArr', array())
            ->assign('type', 'add')->fetch($tpl);
        echo json_encode(array('msg' => $result));

    } else if ($order = $_POST['orderStatement']) { 
        // fresh and resort time group Table
        freshTimeGroup();
    } else {
        // init page data
    }
?>
