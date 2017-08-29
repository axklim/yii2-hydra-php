<?php

namespace gudik\hydraphp;

/**
 * Class Param
 * @package gudik\hydraphp\api
 * @param $link Param
 */
class Param
{
    public $name;
    public $bind;
    public $type;
    public $value;
    public $direction;
    public $required;
    public $link;
    public $field;

    public static function create($properties, $value)
    {
        $param = new static();
        $param->field = $properties['field'];
        $param->name = $properties['name'];
        $param->value = $value;
        $param->type = $properties['type'];
        $param->direction = $properties['direction'];
        $param->required = $properties['required'];
        $param->bind = $param->getBind();
        return $param;
    }

    public function getBind()
    {
        return $this->name  . '_' . rand(1000000, 9999999);
    }

    public function sql()
    {
        $PHP_4SP = '    ';
        if($this->link){
            return $PHP_4SP . $this->field . ' => ' . $this->link->bind;
        }
        if($this->direction == 'IN'){
            return $PHP_4SP . $this->field . ' => :' . $this->bind;
        }
        return $PHP_4SP . $this->field . ' => ' . $this->bind;
    }

    public function sqlDeclare()
    {
        if(is_null($this->value)){
            return $this->bind . ' ' . $this->type . ';';
        }else{
            return $this->bind . ' ' . $this->type . ' := :' . $this->bind . ';';
        }
    }
}
