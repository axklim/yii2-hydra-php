<?php

namespace gudik\hydraphp\tests;


use yii\console\Application;

class TestCase extends \PHPUnit_Framework_TestCase
{
    protected function setUp()
    {
        parent::setUp();
        $this->mockApplication();
    }
    protected function tearDown()
    {
        $this->destroyApplication();
        parent::tearDown();
    }
    protected function mockApplication()
    {
        new Application([
            'id' => 'testapp',
            'basePath' => __DIR__,
            'vendorPath' => dirname(__DIR__) . '/vendor',
            'runtimePath' => __DIR__ . '/runtime',
        ]);
    }
    protected function destroyApplication()
    {
        \Yii::$app = null;
    }
    public function getTemplate($templateName)
    {
        return file_get_contents(__DIR__ . '/data/templates/' . $templateName . '.sql');
    }
}

