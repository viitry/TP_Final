<?php

// autoload_real.php @generated by Composer

class ComposerAutoloaderInitfdde1d0f1a9051f4506076665d9e8ee2
{
    private static $loader;

    public static function loadClassLoader($class)
    {
        if ('Composer\Autoload\ClassLoader' === $class) {
            require __DIR__ . '/ClassLoader.php';
        }
    }

    /**
     * @return \Composer\Autoload\ClassLoader
     */
    public static function getLoader()
    {
        if (null !== self::$loader) {
            return self::$loader;
        }

        require __DIR__ . '/platform_check.php';

        spl_autoload_register(array('ComposerAutoloaderInitfdde1d0f1a9051f4506076665d9e8ee2', 'loadClassLoader'), true, true);
        self::$loader = $loader = new \Composer\Autoload\ClassLoader(\dirname(__DIR__));
        spl_autoload_unregister(array('ComposerAutoloaderInitfdde1d0f1a9051f4506076665d9e8ee2', 'loadClassLoader'));

        require __DIR__ . '/autoload_static.php';
        call_user_func(\Composer\Autoload\ComposerStaticInitfdde1d0f1a9051f4506076665d9e8ee2::getInitializer($loader));

        $loader->register(true);

        return $loader;
    }
}