<?php

namespace gudik\hydraphp\items;


class Account extends BaseItem implements BaseItemInterface
{
    public function in()
    {
        return ['MY_SUBJECT_ID' => 'NUMBER'];
    }

    public function out()
    {
        return ['MY_ACCOUNT_ID' => 'NUMBER'];
    }

    public function getSql()
    {
        return "-- добавление Л/С абоненту;
            SI_USERS_PKG.USER_ACCOUNT_PUT(
                num_N_ACCOUNT_ID      => MY_ACCOUNT_ID,
                num_N_SUBJECT_ID      => MY_SUBJECT_ID,
                num_N_CURRENCY_ID     => SYS_CONTEXT ('CONST', 'CURR_Ruble'),
                vch_VC_ACCOUNT        => '');";
    }
}
