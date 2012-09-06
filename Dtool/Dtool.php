<?php
    class Dtool {

        // print an array
        static function printArr( $arr ) {
            $result = '<ul>';
            foreach ( $arr as $key => $val ) {
                $result .= "<li>[$key] => ";
                if ( is_array($val) ) {
                    $result .= self::printArr($val);
                } else {
                    $result .= $val;
                }
                $result .= '</li>';
            }
            $result .= '</ul>';
            return $result;
        }
    }
?>
