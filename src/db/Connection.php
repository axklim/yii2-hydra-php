<?php

namespace gudik\hydraphp\db;


use yii\base\Component;

class Connection extends Component
{
    public $dsn;
    public $username;
    public $password;
    public $plIp;
    public $plUser;
    public $plPassword;
    public $plCode;
    public $plApplicationId;
    public $commandClass = 'gudik\hydraphp\db\Command';

    private $_connection;

    public function createCommand($sql = null, $params = [])
    {
        /** @var Command $command */
        $command = new $this->commandClass($this, $sql);
        return $command->bindValues($params);
    }

    public function getConnection()
    {
        if(!function_exists('oci_connect')){
            throw new \DomainException('OCI NOT FOUND');
        }
        if($this->_connection){
            return $this->_connection;
        }
        if($this->_connection = oci_connect($this->username, $this->password, $this->dsn)){
            return $this->_connection;
        }
        throw new \DomainException('DB connection error');
    }
}