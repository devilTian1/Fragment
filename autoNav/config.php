<?php
    $navArr = array(
        array('pid' => 0, 'name' => '1',     'href' => '#'),//id = 1
        array('pid' => 0, 'name' => '2',     'href' => '#'),
        array('pid' => 0, 'name' => '3',     'href' => '#'),
        array('pid' => 0, 'name' => '4',     'href' => '#'),
        array('pid' => 0, 'name' => '6',     'href' => '#'),
        array('pid' => 2, 'name' => '2.1',   'href' => '#'),
        array('pid' => 6, 'name' => '2.1.1', 'href' => '#'),
    );

    //test
    /*
    $navArr = array();
    $arr = array(0,1,2,3,4,5,6,7,8,9);
    shuffle($arr);
    for ( $i=0; $i<10; $i++ ) {
        $id = $arr[$i];
        $node = array('pid' => $id, 'name' => $id, 'href' => '#');
        array_push($navArr, $node);
    }
    */
?>
