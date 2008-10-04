<?php
	
	/**
	 * Custom exception class required by Countdown
	 *
	 * @package countdown
	 * @author Caius Durling <dev@caius.name>
	 */
	class InvalidTimeGiven extends Exception {}
	
	/**
	 * Countdown class
	 * 
	 * Counts down to a given date returning a 
	 * variety of formats and options
	 *
	 * @version 0.5
	 * @package countdown
	 * @author Caius Durling <dev@caius.name>
	 */
	class Countdown
	{
		/**
		 * The ending time stored as seconds since the epoch
		 *
		 * @var string
		 */
		private $time;
		
		/**
		 * Kicks it off
		 *
		 * @param string $time 
		 * @author Caius Durling <dev@caius.name>
		 */
		function __construct( $time )
		{
			$this->set_time( $time );
		}
		
		/**
		 * Kicks it off, lets you use Countdown in one line.
		 * eg: <code>Countdown::create("9th November 2008 11:00")->out('weeks');</code>
		 *
		 * @param string $time 
		 * @return Countdown
		 * @author Caius Durling <dev@caius.name>
		 */
		public static function create( $time )
		{
			return new Countdown($time);
		}
		
		/**
		 * Outputs the time remaining, including the time
		 * counting down to if requested.
		 *
		 * @param string $type What format to return the countdown time in.
		 * @param bool $include_time Whether to include the time counting down to or not
		 * @param string $format What format to return the counting down time in
		 * @return string
		 * @author Caius Durling <dev@caius.name>
		 */
		public function out( $type="seconds", $include_time = true, $format = "%c" )
		{
			switch ( $type ) {
				# I'm sure theres a better way to do this dividing
				case 'weeks':
					$num = (((($this->time_diff() / 60) / 60) / 24) / 7);
					break;
				
				case 'days':
					$num = ((($this->time_diff() / 60) / 60) / 24);
					break;
				
				case 'hours':
					$num = (($this->time_diff() / 60) / 60);
					break;
				
				case 'minutes':
					$num = ($this->time_diff() / 60);
					break;
				
				case 'seconds':
					$num = $this->time_diff();
					break;
									
				default:
					$num = $this->time_diff();
					break;
			}
			$num = round( $num );
			$out = "{$num} {$type}";
			if ( $include_time ) {
				$out .= " to " . strftime( $format, $this->time );
			}
			
			return $out;
		}
		
		/**
		 * Calculates time remaining in seconds
		 *
		 * @param string $time Time to count from.
		 * @return integer difference between $time and $this->time
		 * @author Caius Durling <dev@caius.name>
		 */
		private function time_diff( $time = null )
		{
			# PHP is stupid, I should be able to do:
			# function time_diff( $time = time() ) {}
			# or $time ||= time();
			if ( $time === null ) {
				$time = time();
			}
			
			return ($this->time - $time);
		}
		
		/**
		 * Parses the passed string into seconds since the epoch
		 *
		 * @param string $time Time you want to parse
		 * @return void
		 * @author Caius Durling <dev@caius.name>
		 */
		private function set_time( $time )
		{
			$this->time = strtotime( $time );
			
			if ( $this->time === false ) {
				throw new InvalidTimeGiven;
			}
		}
	}
	
	echo Countdown::create("9th November 2008 11:00")->out('weeks');
	# => "5 weeks to Sun Nov  9 11:00:00 2008"

?>