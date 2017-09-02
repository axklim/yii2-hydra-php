<?php

namespace gudik\hydraphp\db;


class Command
{
    private $_sql;
    private $_statement;
    private $db;
    private $_binds = [];

    public function __construct(Connection $db, $sql)
    {
        $this->db = $db;
        $this->setSql($sql);
    }

    public function bindValues($params)
    {
        foreach ($params as $key => $value){
            $this->_binds[$key] = $value;
            oci_bind_by_name($this->getStatement(), $key, $this->_binds[$key], 40);
        }
        return $this;
    }

    public function execute()
    {
        $stmt = $this->getStatement();
        if(!oci_execute($stmt))
        {
            print_r(oci_error($stmt));
            throw new \DomainException('DB execute');
        }
    }

    public function getStatement()
    {
        if($this->_statement){
            return $this->_statement;
        }
        if($this->_statement = oci_parse($this->db->getConnection(), $this->getSql())){
            return $this->_statement;
        }
        throw new \DomainException('DB error');
    }

    public function getSql()
    {
        return $this->_sql;
    }

    public function setSql($sql)
    {
        $this->_sql = $sql;
    }
}