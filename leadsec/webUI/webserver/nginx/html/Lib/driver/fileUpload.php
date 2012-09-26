<?php
    require_once(WEB_PATH . '/Lib/core/upload.php');
    /**
     *
     */
    class FileUpload extends UPLOAD {

	private $files = array();

	public function __construct($files = NULL) {
            if ($files === NULL) {
	        $this->files = $_FILES;
	    } else {
	        $this->files = $files;
	    }
	}

        private function getUploadFileErrInfo($err) {
	    switch($err) {
                case UPLOAD_ERR_OK :
		    return 'No error';
	        case UPLOAD_ERR_INI_SIZE :
		    return 'Larger than max_upload_filesize.';
    	        case UPLOAD_ERR_FORM_SIZE :
		    return 'Larger than MAX_FILE_SIZE.';
	        case UPLOAD_ERR_PARTIAL :
		    return 'partial upload.';
   	  	case UPLOAD_ERR_NO_FILE :
		    return 'No file.';
	    	case UPLOAD_ERR_NO_TMP_DIR :
		    return 'No temparary directory.';
                case UPLOAD_ERR_CANT_WRITE :
		    return 'Can not write to disk.';
	        default :
		    return 'Unknown upload error.'; 
	    }
	}

	public function upload() {
	    $status = -1;
	    $errMsg = array();
            foreach ($this->files as $fname => $info) {
		$error   = $info['error'];
		$name    = $info['name'];
		$tmpName = $info['tmp_name'];
                if ($this->getUploadFileErrInfo($error) === 'No error') {
		    $destination = UPLOAD_PATH . '/' . $name;
		    if (is_uploaded_file($tmpName) === false) {
                        $errMsg[] = "Possible file upload attack: $name";
			continue;
		    }
		    if (!move_uploaded_file($tmpName, $destination)) {
			$errMsg[] = 
			    "Can not move $tmpName to $destination";
		    }
		} else {
		    $errMsg[] = "$fname|$name:" .
			$this->getUploadFileErrInfo($error);
		}
	    }
	    if (count($errMsg) === 0) {
		$status = 0;
		$result = array('upload successful');
	    } else {
		$status = -1;
		$result = $errMsg;
	    }
	    return array($status, $result);
	}
    }
?>
