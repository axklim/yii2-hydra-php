<?php

namespace gudik\hydraphp;


use yii\db\Command;
use gudik\hydraphp\Connection;

class PDOHelper
{
    /** @var Connection $_connection */
    private $_connection;
    /** @var Builder $_phphydra */
    private $_hydraphp;
    /** @var Command $_command */
    private $_command;

    public static function create(Connection $connection, Builder $hydraphp, $command = null)
    {
        $helper = new self();
        $helper->_connection = $connection;
        $helper->_hydraphp = $hydraphp;
        $helper->_command = $command ? $command : $helper->_connection->createCommand();
        return $helper;
    }

    public function execute()
    {
        return $this->setSql()->bindValues()->bindAuth()->_command->execute();
    }

    public function bindAuth()
    {
        $this->_command->bindValues([
            'plIp' => $this->_connection->plIp,
            'plUser' => $this->_connection->plUser,
            'plPassword' => $this->_connection->plPassword,
            'plCode' => $this->_connection->plCode,
            'plApplicationId' => $this->_connection->plApplicationId,
        ]);
        return $this;
    }

    public function bindValues()
    {
        $this->_command->bindValues($this->_hydraphp->getBinds());
        return $this;
    }

    public function setSql()
    {
        $this->_command->setSql($this->_hydraphp->sql());
        return $this;
    }
}