<?php

namespace gudik\hydraphp;


use gudik\hydraphp\db\Command;
use gudik\hydraphp\db\Connection;
use PDO;

class OCIHelper
{
    /** @var Connection $_connection */
    private $_connection;
    /** @var Builder $_phphydra */
    private $_hydraphp;
    /** @var Command $_command */
    private $_command;

    public static function create($connection, Builder $hydraphp, $command = null)
    {
        $helper = new self();
        $helper->_connection = $connection;
        $helper->_hydraphp = $hydraphp;
        $helper->_command = $helper->_connection->createCommand();
        return $helper;
    }

    public function execute()
    {
        $this->setSql()->bindAuth()->bindValues()->bindParams()->_command->execute();
    }

    public function bindAuth()
    {
        $this->_command->bindValues([
            ':plIp' => $this->_connection->plIp,
            ':plUser' => $this->_connection->plUser,
            ':plPassword' => $this->_connection->plPassword,
            ':plCode' => $this->_connection->plCode,
            ':plApplicationId' => $this->_connection->plApplicationId,
        ]);
        return $this;
    }

    public function bindValues()
    {
        $this->_command->bindValues($this->_hydraphp->getBinds());
        return $this;
    }

    public function bindParams()
    {
        foreach ($this->_hydraphp->getBindParams() as $bind => &$value)
        {
            $this->_command->bindParam(':'.$bind, $value,  PDO::PARAM_STR|PDO::PARAM_INPUT_OUTPUT, 512);
        }
        return $this;
    }

    public function setSql()
    {
        $this->_command->setSql($this->_hydraphp->sql());
        return $this;
    }

    public function getCommand()
    {
        return $this->_command;
    }
}