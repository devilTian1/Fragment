<?php
    require_once('config.php');
    // if $node['children'] does not exist, then add it
    function addChildrenArr( &$node ) {
        if ( !is_array($node['children']) ) {
            $node['children'] = array();   
        }
    }

    // remote non-root node
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

    // show Nav
    function showNav( $navArr ) {
        echo "<ul>";
        foreach ( $navArr as $key => $root ) {
            echo "<li>{$root['name']}</li>";
            $children = $root['children'];
            if ( is_array( $children ) ) {
                showNav($children);
            }
        }
        echo "</ul>";
    }

    sortNavArr(&$navArr);
    showNav($navArr);
?>
