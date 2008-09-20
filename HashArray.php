<?php 

/**
 * A class to hash an array of any nested level into
 * an MD5 hash.
 *
 * @author Caius Durling <dev@caius.name>
 */
class HashArray
{
	/**
	 * The array passed in
	 *
	 * @var array
	 */
	public $array = array();
	
	/**
	 * The hash of {@link $array}
	 *
	 * @var string
	 */
	public $hash = "";
	
	/**
	 * The array concatenated into an array
	 *
	 * @var string
	 */
	protected $string;
	
	/**
	 * Hashes the array and returns it
	 *
	 * @param array $array array to hash
	 * @return string Hash of array
	 * @author Caius Durling <dev@caius.name>
	 */
	function __construct( $array ) {
		$this->array = $array;
		$this->_hash_array();
	}
	
	/**
	 * MD5's the string of the array
	 *
	 * @return void
	 * @author Caius Durling <dev@caius.name>
	 */
	protected function _hash_array()
	{
		$this->__toString();
		$this->hash = md5( $this->string );
	}
	
	/**
	 * Reduces the array down to a single string
	 *
	 * @return void
	 * @author Caius Durling <dev@caius.name>
	 */
	protected function __toString( $array=null )
	{
		# Check if its set or not
		isset($array) ? $a = $array : $a = $this->array;
		
		# Array imploding is faster than string
		# concatenation apparently
		$out = array();
		foreach ($a as $key => $value) {
			$out[] = $key;
			$out[] = ( is_array($value) ? $this->__toString($value) : $value );
		}
		# Concat it
		$out = implode("", $out);
		# And figure out what to do with the output
		if ( isset($array) ) {
			# They passed it in
			return $out;
		} else {
			# Nothing was passed in
			$this->string = $out;
		}
	}
}

$a = array( "a", "b", "c" );
$b = $a;
$b[] = "d";

$a_h = new HashArray( $a );
$b_h = new HashArray( $b );

var_dump( ($a_h->hash == $b_h->hash) ); # => bool(false)


