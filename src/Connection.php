<?php

namespace gudik\hydraphp;


class Connection extends \yii\db\Connection
{
    public $plIp;
    public $plUser;
    public $plPassword;
    public $plCode;
    public $plApplicationId;

    /**
     * @param $q
     * @param array $params
     * @return \yii\db\Command the DB command
     */
    public function createPlSqlCommand2($q, $params = [])
    {
        return $this->createCommand($q, $params)->bindValues([
            'plIp' => $this->plIp,
            'plUser' => $this->plUser,
            'plPassword' => $this->plPassword,
            'plCode' => $this->plCode,
            'plApplicationId' => $this->plApplicationId,
        ]);
    }

}
