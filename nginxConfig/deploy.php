<?php
	date_default_timezone_set('Asia/Singapore');
	
	/**
	 * Simple interface that subclasses should implement
	 */
	 interface iDeploy{
		 /**
		  * Set defaults for this repo
		  */
		public function init();
	 }
	 
	/**
	 * Generic class for all repository classes to extend.
	 * Subclasses must implement a init() method
	 */	 
	class Deploy{	
		
		public $repository = "/home/ubuntu/repos/";
		
		protected $_remote = "bitbucket";
		
		protected $_branch = "master";
		
		public function __construct($repo = null)
		{
			if(class_exists($repo))
			{
				$repo = new $repo;
				if(is_subclass_of($repo, "Deploy"))
				{
					$repo->run("init");
					return $repo;
				}
			}			
			
			return $this;
		}

		/**
		 * A static factory method
		 * */		
		public static function factory($repo = null)
		{
			return new Deploy($repo);
		}
		
		/**
		 * A simple method that runs internal callbacks if they are callable
		 * */
		protected function run($event)
		{
			if(is_callable([$this, $event]))
			{
				return $this->{$event}();
			}
			
			return true;
		}
		
		public function execute()
		{
			try
			{
				// Make sure we're in the right directory
				exec('cd ' . $this->repository, $output);
				//$this->log('Changing working directory... '.implode(' ', $output));	
				$this->run("before_pull");		
				
				// In case any changes were made locally, make sure to reset it.
				exec('git reset --hard HEAD', $output);	
				
				// pull changes
				exec('git pull '.$this->_remote.' '.$this->_branch, $output);
				
				$this->run("after_pull");
			}
			catch(Exception $e)
			{
				
			} 
		}
		
		/*Callbacks - Not in interface, cos not needed all the time*/
		public function before_pull(){}
		public function after_pull(){}	
		
	}

	class Api extends Deploy implements iDeploy{
		
		public function init()
		{
			$this->repository  = $this->repository . 'api.git';
		}
		
	}
	
	class App extends Deploy implements iDeploy{
		
		public function init()
		{
			$this->repository  = $this->repository . 'app.git';
		}
		
	}	
	
	class Common extends Deploy implements iDeploy{
		
		public function init()
		{
			$this->repository  = $this->repository . 'common.git';
		}
		
	}	
	
	$repos = ["api", "app", "common"];
	
	if(!empty($_GET) && isset($_GET["repo"]) && in_array($_GET["repo"], $repos))
	{
		$repo = strtolower($_GET["repo"]);
		return $d = Deploy::factory($repo)->execute();
	}
	header('HTTP/1.0 404 Not Found');
	echo "<h1>The repository page was not found</h1h1>";
?>
