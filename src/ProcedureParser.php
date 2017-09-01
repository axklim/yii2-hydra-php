<?php
namespace gudik\hydraphp;

class ProcedureParser
{
    CONST TYPE_NUMBER = 'NUMBER';
    CONST TYPE_VARCHAR = 'VARCHAR(512)';
    CONST TYPE_DATATIME = 'DATETIME';

    public static function parse($package, $procedure)
    {
        $file = __DIR__ . '/hydra/packages/' . $package . '.pls';
        $file = file_get_contents($file);
        $matches = [];
        preg_match('/PROCEDURE ' . $procedure . '\((.*?)\)\;/s', $file, $matches);
        $ar = explode(PHP_EOL, $matches[1]);
        $ret1 = [];
        foreach ($ar as $str)
        {
            if($ret = self::getType($str)){
                $ret1[$ret['name']] = $ret;
            }
        }
        return $ret1;
    }

    public static function getType($str)
    {
        if(strstr($str, ' IN OUT ')){
            $ret['direction'] = 'OUT';
        }elseif (strstr($str, ' IN ')){
            $ret['direction'] = 'IN';
        }else{
            return false;
        }
        // required param
        strstr($str, ' := ') ? $ret['required'] = false : $ret['required'] = true;

        $types = [ProcedureParser::TYPE_NUMBER => 'num_N_', ProcedureParser::TYPE_VARCHAR => 'vch_VC_', ProcedureParser::TYPE_DATATIME => 'dt_D_'];
        foreach ($types as $type => $prefix){
            $matches = [];
            if(strstr($str, $prefix) && preg_match('/'.$prefix.'(\w+)/', $str, $matches) ){
                $ret['field'] = $matches[0];
                $ret['name'] = $matches[1];
                $ret['type'] = $type;
                return $ret;
            }
        }
        return false;
    }
}