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

    // if $arr has not the key 'children', add it
    function addChildrenArr( &$node ) {
        if ( !is_array($node['children']) ) {
            $node['children'] = array();   
        }
    }

    // remote non parent node
    function delNonParentNode( &$navArr ) {
        foreach ( $navArr as $key => $node ) {
            if ( $node['pid'] !== 0 ) {
                unset($navArr[$key]);
            }
        }
    }
    
    // sort all nav nodes
    function sortNavArr( &$navArr ) {
        foreach ( $navArr as $key => $node ) {
            $pid = $node['pid'];
            if ( $pid !== 0 ) {
                addChildrenArr(&$navArr[$pid-1]);
                array_push($navArr[$pid-1]['children'], &$navArr[$key]);
            }
        }
        delNonParentNode( &$navArr );
    }



    // print an array, instead of function var_dump or var_export
    function printArr( $arr ) {
        $result = '<ul>';
        foreach ( $arr as $key => $val ) {
            $result .= "<li>[$key] => ";
            if ( is_array($val) ) {
                $result .= printArr($val);
            } else {
                $result .= $val;
            }
            $result .= '</li>';
        }
        $result .= '</ul>';
        return $result;
    }

    sortNavArr(&$navArr);
    echo printArr( $navArr );
    echo '<br/>';
    var_export( $navArr );
?>
