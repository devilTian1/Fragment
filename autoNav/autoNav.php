<?php
    require_once('../Dtool/Dtool.php');
    require_once('config.php');
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
    /*
    echo 'BEFORE:<BR/>';
    echo Dtool::printArr( $navArr );

    sortNavArr(&$navArr);

    echo 'AFTER:<BR/>';
    echo Dtool::printArr( $navArr );
    echo '<br/>';
    */
    sortNavArr(&$navArr);

    function showNav( $navArr ) {
        echo "<ul>";
        foreach ( $navArr as $key => $root ) {
            echo "<li>{$root['name']}</li>";
            if ( is_array( $root['children'] ) ) {
                showNav($root['children']);
            }
        }
        echo "</ul>";
    }
    showNav($navArr);
?>
