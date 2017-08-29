<?php

namespace gudik\hydraphp;


class Builder
{
    private $_procedures = [];

    public function create($procedure)
    {
        list($package, $procedure) = explode('.', $procedure);
        $procedure = new Procedure($package, $procedure);
        $this->_procedures[] = $procedure;
        return $procedure;
    }

    public function sql()
    {
        $q = 'DECLARE' . PHP_EOL;
        $q .= $this->declareSection() . PHP_EOL;
        $q .= 'BEGIN' . PHP_EOL;
        $q .= $this->authSection() . PHP_EOL;
        $q .= $this->procedureSection();
        $q .= 'END;' . PHP_EOL;
        return $q;
    }

    public function procedureSection()
    {
        return implode('', array_map(function($procedure){
            /** @var Procedure $procedure */
            return $procedure->sql();
        }, $this->_procedures));
    }
    public function authSection()
    {
        $q = 'MAIN.INIT(vch_VC_IP => :plIp, vch_VC_USER => :plUser, vch_VC_PASS => :plPassword, ';
        $q .= 'vch_VC_APP_CODE => :plCode, vch_VC_CLN_APPID => :plApplicationId);' . PHP_EOL;
        $q .= 'MAIN.SET_ACTIVE_FIRM(num_N_FIRM_ID => 100);';
        return $q;
    }

    public function declareSection()
    {
        $declare = [];
        array_walk_recursive($this->getOutParams(), function($param) use(&$declare){
            /** @var Param $param */
            $declare[] = $param->sqlDeclare();
        });
        return implode(PHP_EOL, $declare);
    }

    /**
     * Return all Out params for each procedure
     * @return array
     */
    public function getOutParams()
    {
        return array_map(function($procedure){
            /** @var Procedure $procedure */
            return $procedure->getOutParams();
        }, $this->_procedures);
    }

    /**
     * Return all In params for each procedure
     * @return array
     */
    public function getInParams()
    {
        return array_map(function($procedure){
            /** @var Procedure $procedure */
            return $procedure->getInParams();
        }, $this->_procedures);
    }

    public function getParams()
    {
        return array_map(function($procedure){
            /** @var Procedure $procedure */
            return $procedure->getParams();
        }, $this->_procedures);
    }
    public function getBinds()
    {
        return array_reduce(array_map(function($procedure){
            /** @var Procedure $procedure */
            return ($procedure->getBinds());
        }, $this->_procedures), 'array_merge', []);
    }
}
