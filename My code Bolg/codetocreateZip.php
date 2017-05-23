<?php
$archive_name = $_SERVER['DOCUMENT_ROOT'].'/PPM/test/file.zip'; // name of zip file
$archive_folder = $_SERVER['DOCUMENT_ROOT'].'/PPM/'; // the folder which you archivate
 
zipFile($archive_folder,$archive_name, true);

/**
 * function zipFile.  Creates a zip file from source to destination
 *
 * @param  string $source Source path for zip
 * @param  string $destination Destination path for zip
 * @param  string|boolean $flag OPTIONAL If true includes the folder also
 * @return boolean
 */
function zipFile($source, $destination, $flag = '')
{
    if (!extension_loaded('zip') || !file_exists($source)) {
        return false;
    }

    $zip = new ZipArchive();
    if (!$zip->open($destination, ZIPARCHIVE::CREATE)) {
        return false;
    }

    $source = str_replace('\\', '/', realpath($source));
    if($flag)
    {
        $flag = basename($source) . '/';
        //$zip->addEmptyDir(basename($source) . '/');
    }

    if (is_dir($source) === true)
    {
        $files = new RecursiveIteratorIterator(new RecursiveDirectoryIterator($source), RecursiveIteratorIterator::SELF_FIRST);
        foreach ($files as $file)
        {
            $file = str_replace('\\', '/', realpath($file));

            if (is_dir($file) === true)
            {
                $zip->addEmptyDir(str_replace($source . '/', '', $flag.$file . '/'));
            }
            else if (is_file($file) === true)
            {
                $zip->addFromString(str_replace($source . '/', '', $flag.$file), file_get_contents($file));
            }
        }
    }
    else if (is_file($source) === true)
    {
        $zip->addFromString($flag.basename($source), file_get_contents($source));
    }

    return $zip->close();
}

?>
