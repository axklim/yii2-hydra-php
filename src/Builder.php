<?php

namespace gudik\hydraphp;

use gudik\hydraphp\items\BaseItemInterface;
use PDO;
use Yii;
use yii\base\Exception;

/**
 * TODO: Проработать значения по умолчанию
 * TODO: Добавить ф-цию получения Субъекта, и потом добавлть его в $obj->link()
 * $hydra = new Builder();
 * $subj = new Subject(12565548);
 * $hydra->link($subj, null);
 * $acc = new Account();
 * $hydra->link($acc, $subj);
 *
 *
 * Class Builder
 * @package common\helpers\hydraphp
 */
class Builder
{
    /**
     * @var array BaseItem
     */
    private $items = [];

    private $iter = 1;
    /**
     * @var Connection
     */
    public $db;

    public $rawSql;

    public function __construct(Connection $connection)
    {
        $this->db = $connection;
    }

    /**
     * @param BaseItemInterface $object
     * @throws Exception
     */
    private function add(BaseItemInterface $object)
    {
//        foreach(array_keys($object->in()) as $varName){
//            $object->linkerIn[] = preg_replace('/^MY_/', 'MY' . $this->iter . '_', $varName);
//        }
//
        foreach(array_keys($object->out()) as $varName){
            $object->linkerOut[$varName] = preg_replace('/^MY_/', 'MY' . $this->iter . '_', $varName);
        }

//        foreach(array_keys($object->in()) as $in)
//        {
//            if(isset($object[$in])){
//                continue;
//            }
//            if( ! in_array($in, array_keys($this->getOuts()))){
//                throw new Exception('Не определена переменная: ' . $in);
//            }
//        }
        $this->items[$this->iter] = $object;
        $object->itemId = $this->iter;
        $this->iter++;
    }

    public function link(BaseItemInterface $objChild, BaseItemInterface $objParent = null)
    {
        if($objParent && !$objParent->itemId){
            $this->add($objParent);
        }

        if(!$objChild->itemId){
            $this->add($objChild);
        }

        foreach (array_keys($objChild->in()) as $varName){
            if(isset($objChild[$varName])){
                $objChild->linkerIn[$varName] = preg_replace('/^MY_/', 'MY' . $objChild->itemId . '_', $varName);
                continue;
            }
            if(!$objParent || !in_array($varName, array_keys($objParent->out()))){
                throw new Exception('Не определена переменная: ' . $varName);
            }
            $objChild->linkerIn[$varName] = preg_replace('/^MY_/', 'MY' . $objParent->itemId . '_', $varName);
        }
    }

    /**
     * @param BaseItemInterface $objChild
     * @param $objParents array of BaseItemInterface
     * @throws Exception
     */
    public function multiLink(BaseItemInterface $objChild, $objParents)
    {
        foreach ($objParents as $objParent)
        {
            if($objParent && !$objParent->itemId){
                $this->add($objParent);
            }
        }

        if(!$objChild->itemId){
            $this->add($objChild);
        }

        foreach (array_keys($objChild->in()) as $varName){
            if(isset($objChild[$varName])){
                $objChild->linkerIn[$varName] = preg_replace('/^MY_/', 'MY' . $objChild->itemId . '_', $varName);
                continue;
            }

            $outs = call_user_func_array('array_merge', array_map(function($obj){return $obj->out();}, $objParents));
            if(!in_array($varName, array_keys($outs))){
                throw new Exception('Не определена переменная: ' . $varName);
            }

            foreach ($objParents as $objParent)
            {
                if(in_array($varName, array_keys($objParent->out()))){
                    $objChild->linkerIn[$varName] = preg_replace('/^MY_/', 'MY' . $objParent->itemId . '_', $varName);
                }
            }
        }
    }

    public function execute($dump = 0)
    {
        $ar = [];
        $command = $this->db->createPlSqlCommand2($this->getQuery());

        $command->bindValues($this->getValues());

        foreach ($this->getOuts() as $varName => $varType)
        {
            switch ($varType){
                case 'NUMBER':
                    $command->bindParam(':' . $varName, $ar[$varName], PDO::PARAM_INPUT_OUTPUT, 100);
                break;
                case 'VARCHAR2(512)':
                    $command->bindParam(':' . $varName, $ar[$varName], PDO::PARAM_INPUT_OUTPUT, 512);
                break;
                default:
                    throw new Exception('Не найден бинд для типа данных: ' . $varType);
            }
        }
        $this->rawSql = $command->getRawSql();
        if($dump){
            var_dump($this->rawSql);
        }
        $command->execute();
        return $ar;
    }

    public function getQuery()
    {
        $q = '-- Сгенерировано(' . date('Y-m-d H:i:s') . '): ' . PHP_EOL;
        $q .= '-- ' . __METHOD__ . PHP_EOL;
        $q .= 'DECLARE' . PHP_EOL;
        $q .= $this->getSqlDeclare() . PHP_EOL;
        $q .= 'BEGIN' . PHP_EOL;
        $q .= $this->getSqlAuth() . PHP_EOL;
        $q .= $this->getSqlValues() . PHP_EOL;
        $q .= $this->getSqlItems() . PHP_EOL;
        $q .= $this->getSqlReturnParams() . PHP_EOL;
        $q .= 'END;' . PHP_EOL;
        return $q;
    }

    private function getSqlDeclare()
    {
        $declare = [];
        foreach ($this->items as $objItem)
        {
            foreach ($objItem->linkerIn as $varName => $varNameLinker) {
                $declare[$varNameLinker] = $objItem->in()[$varName];
            }
            foreach ($objItem->linkerOut as $varName => $varNameLinker) {
                $declare[$varNameLinker] = $objItem->out()[$varName];
            }
        }
        $declare['N_TMP1'] = 'NUMBER';
        $declare['N_TMP2'] = 'NUMBER';
        return implode(PHP_EOL, array_map(function($varType, $varName){return $varName . ' ' . $varType . ';';},
                                            $declare, array_keys($declare)));
    }

    private function getSqlAuth()
    {
        return 'MAIN.INIT(
            vch_VC_IP => :plIp,
            vch_VC_USER => :plUser,
            vch_VC_PASS => :plPassword,
            vch_VC_APP_CODE => :plCode,
            vch_VC_CLN_APPID => :plApplicationId);
            MAIN.SET_ACTIVE_FIRM(num_N_FIRM_ID => 100);';
    }

    private function getSqlItems()
    {
        $q = '';
        foreach ($this->items as $item)
        {
            $q .= '-- Сгенерировано: ' . PHP_EOL;
            $q .= '-- ' . $item::className() . PHP_EOL;

            $q_item = $item->sql;
            foreach ($item->linkerIn as $varName => $varNameLinker){
                $q_item = str_replace($varName, $varNameLinker, $q_item);
            }
            foreach ($item->linkerOut as $varName => $varNameLinker){
                $q_item = str_replace($varName, $varNameLinker, $q_item);
            }
            $q .= $q_item;
        }
        return $q;
    }

    private function getSqlValues()
    {
        return implode(PHP_EOL, array_map(function($varName){
            return $varName . ' := :' . $varName . ';';
        }, array_keys($this->getValues())));
    }

    private function getValues()
    {
        $ar = call_user_func_array('array_merge', array_map(function($item){
            $ret = [];
            foreach ($item->getValues() as $varName => $varValue){
                $ret[$item->linkerIn[$varName]] = $varValue;
            }
            return $ret;
        }, $this->items));
        return $ar;
    }

    private function getSqlReturnParams()
    {
        echo '---' . PHP_EOL;
        $ar = array_map(function($varName){return ':' . $varName . ' := ' . $varName . ';';},
            array_keys($this->getOuts()));
        return implode(PHP_EOL, $ar);
    }

    private function getOuts()
    {
        $ar = array_map(function($item){
                $ret = [];
                foreach ($item->out() as $varName => $varType)
                {
                    $ret[$item->linkerOut[$varName]] = $varType;
                }
                return $ret;
            }, $this->items);
        if(!$ar){
            return [];
        }
        return call_user_func_array('array_merge', $ar);
    }
}
