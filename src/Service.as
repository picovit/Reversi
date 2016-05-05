package
{
	import configs.ConfigModel;

	public class Service
	{
		static private var _init:Service;

		static public function get instance():Service
		{
			if(!_init) _init = new Service();
			return _init; 
		}
		
		private var _configModel:ConfigModel;
		
		public function get configModel():ConfigModel
		{
			return _configModel;
		}

		public function set configModel(value:ConfigModel):void
		{
			_configModel = value;
		}

		
		
//		public function get config():ConfigModel
//		{
//			if(!_config) _config = new ConfigModel();
//			return _config;
//		}
	}
}