<?php
namespace gudik\hydraphp;

class ProcedureParser
{
    CONST TYPE_NUMBER = 'NUMBER';
    CONST TYPE_VARCHAR = 'VARCHAR(512)';
    CONST TYPE_DATATIME = 'DATETIME';

    public static function parse($package, $procedure, $packagesPath = null)
    {
        $file = __DIR__ . '/hydra/packages/' . $package . '.pls';
        if($packagesPath){
            $file = $packagesPath . '/' . $package . '.pls';
        }
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
        if(strstr($str, ' IN OUT ') || strstr($str, ' OUT ')){
            $ret['direction'] = 'OUT';
        }elseif (strstr($str, ' IN ')){
            $ret['direction'] = 'IN';
        }else{
            return false;
        }
        // required param
        strstr($str, ' := ') ? $ret['required'] = false : $ret['required'] = true;

        $prefixes = self::hydraPrefixes();

        foreach ($prefixes as $prefix => $type){
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

    private static function hydraPrefixes()
    {
        return [
            'num_N_'    => ProcedureParser::TYPE_NUMBER,
            'b_'        => ProcedureParser::TYPE_NUMBER,
            'vch_VC_'   => ProcedureParser::TYPE_VARCHAR,
            'dt_D_'     => ProcedureParser::TYPE_DATATIME,
            'ch_C_'     => ProcedureParser::TYPE_VARCHAR,
        ];
    }
}