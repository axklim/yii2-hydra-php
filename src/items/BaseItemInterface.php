<?php

namespace gudik\hydraphp\items;


interface BaseItemInterface
{
    public function in();

    public function out();

    public function getSql();
}