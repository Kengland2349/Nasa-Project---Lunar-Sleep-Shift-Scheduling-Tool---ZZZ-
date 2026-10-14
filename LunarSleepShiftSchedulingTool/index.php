<?php
    include 'header.php';
    $time = 5;
    $money = 10;
    $message = "time * money is not 50";
    
    if (($time * $money) == 50) {
        $message = "time * money is 50";
    }
    
    $foods = ['apple' => 'fruit', 'orange' => 'fruit', 'cake' => 'bread', 'green_beans' => 'vegetable', 'Tangerine' => 'fruit', 'cabbage' => 'vegetable'];
    $fruitNum = 0;
    $vegNum = 0;
    foreach ($foods as $food => $type) {
        if ($type == 'fruit') {
            $fruitNum += 1;
        } else if ($type == 'vegetable') {
            $vegNum += 1;
        }
    }
    echo "The number of fruits are $fruitNum<br>";
    echo "The number of vegetables are $vegNum<br>";
?>


<body>
    <header>
        <table>
            <tr>
            	<td><img src="ZZZNASA.png" alt="Team Logo" width="100" height="100"></td>
                <td>Lunar Sleep Shift Scheduling Tool</td>
            </tr>
        </table>
    
      	<hr>
    </header>
    
    <nav>
    	
    </nav>
    
    <table>
    	<tr> <td><a href="https://forms.gle/Fr42zjr7jhQyP1eH8" class="pseudo-button" role="button" target="_blank" rel="noopener noreferrer">Forms Morning</a></td> </tr>
    	<tr> <td><a href="https://forms.gle/aRLzofMpMajSWP4HA" class="pseudo-button" role="button" target="_blank" rel="noopener noreferrer">Before Sleep</a></td> </tr>
    	<tr> <td>BUTTON 1</td> </tr>
    	<tr> <td onclick="button1Thing()">BUTTON 1</td> </tr>
    </table>
    
    <button style="position: relative; height: 500px;" onclick="button1Thing()">hello</button>
    
    <p><?php echo $message?></p>
<?php
    include 'footer.php';
?>