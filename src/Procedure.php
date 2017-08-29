<?php
namespace gudik\hydraphp;


class Procedure
{
    public $_items = [];
    public $package;
    public $procedure;
    public $params = [];

    public function __construct($package, $procedure)
    {
        $this->package = $package;
        $this->procedure = $procedure;
        $this->_items = ProcedureParser::parse($package, $procedure);
        array_walk($this->getRequiredItems(), function($item){
            $this->__set($item['name'], null);
        });
    }

    public function __set($name, $value)
    {
        if(!isset($this->_items[$name])){
            throw new \DomainException('Property ' . $name . ' not found in ' . $this->package . '\\' . $this->procedure);
        }
        $this->params[$name] = Param::create($this->_items[$name], $value);
    }

    public function __get($name)
    {
        if(!isset($this->_items[$name])){
            throw new \DomainException('Property ' . $name . ' not found in ' . $this->package . '\\' . $this->procedure);
        }
        return isset($this->params[$name])?$this->params[$name]->value:null;
    }

    public function __call($name, $arguments)
    {
        if(!isset($this->_items[$name])){
            throw new \DomainException('Property ' . $name . ' not found in ' . $this->package . '\\' . $this->procedure);
        }

        if(!isset($this->params[$name])){
            $this->__set($name, null);
        }

        if(isset($arguments[0]) && $arguments[0] instanceof Param){
            $this->params[$name]->link = $arguments[0];
        }
        return $this->params[$name];
    }

    public function sql()
    {
        $q = $this->package . '.' . $this->procedure . '(' . PHP_EOL;
        $q .= implode(',' . PHP_EOL, array_map(function($param){
            /** @var Param $param */
            return $param->sql();
        }, $this->params));
        $q .= ');' . PHP_EOL;
        return $q;
    }

    public function getRequiredItems()
    {
        return array_filter($this->_items, function($item){
            return $item['required'];
        });
    }

    public function getOutParams()
    {
        return array_filter($this->params, function($param){
            /** @var Param $param */
            return $param->direction == 'OUT';
        });
    }

    public function getInParams()
    {
        return array_filter($this->params, function($param){
            /** @var Param $param */
            return $param->direction == 'IN';
        });
    }

    public function getParams()
    {
        return array_filter($this->params, function($param){
            /** @var Param $param */
            return true;
        });
    }

    public function getBinds()
    {
        $binds = [];
        array_walk($this->getInParams(), function($param) use(&$binds){
            /** @var Param $param */
            if(!$param->link){
                $binds = [':' . $param->bind => $param->value] + $binds;
            }
        });
        return $binds;
    }
}
