<!-- 
	Pings each machine in turn and links to them
	if they are active. I use it at http://caius.in/
	to ping my machines on the internal network
	and link through to them only if they are active.
-->

<!-- Remember to format this into proper HTML or I'll send gsnedders after you! -->
<?php
#  Pings IRIs

class Ping
{
	
	public $data;
	
	public function __construct( $data )
	{
		// Basic error checking
		if ( ! is_array( $data ) ) {
			die( "You need to pass an array in..." );
		}
		$this->data = $data;
		$this->ping();
	}
	
	private function ping()
	{
		for ($i=0; $i < count( $this->data ); $i++) { 
			$this->data[$i]['raw'] = `ping -c1 -t1 {$this->data[$i]['ip']}`;
			if ( strstr( $this->data[$i]['raw'], " 0%" ) ) {
				$this->data[$i]['ping'] = true;
			} else {
				$this->data[$i]['ping'] = false;
			}
		}
	}
}

$machines = array(
		array(
			'name' => 'Julius',
			'url' => 'julius.caius.in',
			'ip' => '192.168.1.98',
			'desc' => 'Macbook'
		),
		array(
			'name' => 'Cleo',
			'url' => 'cleo.caius.in',
			'ip' => '192.168.1.102',
			'desc' => 'Windows Boxen'
		),
		array(
			'name' => 'Epic',
			'url' => 'eee.caius.in',
			'ip' => '192.168.1.15',
			'desc' => 'Eeepc'
		),
		array(
			'name' => 'Slice',
			'url' => 'caius.name',
			'ip' => '208.78.100.145',
			'desc' => 'Slicehost slice'
		)
	);


$ping = new Ping( $machines );

?>


<ul>
	<?php foreach ( $ping->data as $box ): ?>
		
		<?php if ( $box['ping'] ): ?>
			<li class="up">
				<a href="http://<?php echo $box['url'] ?>/">
					<?php echo $box['name'] ?> &raquo; <?php echo $box['desc'] ?>
				</a>
			</li>
		<?php else : ?>
			<li class="down">
					<?php echo $box['name'] ?>
			</li>
		<?php endif ?>
		
	<?php endforeach ?>
</ul>
