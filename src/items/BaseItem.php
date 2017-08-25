<?php

namespace gudik\hydraphp\items;

use Yii;
use yii\base\Exception;
use yii\base\Object;

/**
 * Class BaseItem
 * @package common\helpers\hydraphp\items
 */

class BaseItem extends Object implements \ArrayAccess
{
    public $itemId = 0;

    public $values = [];

    public $linkerIn = [];

    public function in()
    {
        return [];
    }

    public $linkerOut = [];

    public function out()
    {
        return [];
    }

    public function def()
    {
        return [];
    }

    public function getValues()
    {
        return $this->values;
    }

    // ArrayAccess
    public function offsetExists($offset)
    {
        return isset($this->values[$offset]);
    }

    public function offsetGet($offset)
    {
        return $this->offsetExists($offset) ? $this->values[$offset] : null;
    }

    public function offsetSet($offset, $value)
    {
        $this->setValue($offset, $value);
    }

    public function offsetUnset($offset)
    {
        unset($this->values[$offset]);
    }

    public function setValue($key, $value)
    {
        $in = array_keys($this->in());
        if(!in_array($key, $in)){
            throw new Exception('Переменная ' . $key . ' для ' . self::className() . ' не доступна');
        }
        $this->values[$key] = $value;
    }
}
