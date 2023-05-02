<?php include "config.php";?>
<?php session_start();?>
<?php 

if (!isset($_SESSION['user'])){
if (isset($_POST['login'])) {
  $Username = mysqli_real_escape_string($conn,$_POST['Username']);
  $Password = mysqli_real_escape_string($conn,$_POST['Password']);
  $query = "SELECT * FROM registration WHERE Username= '$Username' AND Password = '$Password'";
  $fire = mysqli_query($conn,$query);
  if($fire) {
        if(mysqli_num_rows($fire) == 1) {
           $_SESSION['user'] = true;
       $_SESSION['Username'] = $Username;
       $_SESSION['Password'] = $Password;
  
            echo "<script>";
            echo "alert('Login Successful.!!');";
           
            echo 'window.location.href="index.php";';
            echo "</script>";
        //    header("Location: profile.php");
        //    echo "<center><h4 style='color:green'>Success</h4></center>";
  }else{
   $vali = '<div id="alert1" class="container col-sm-12 col-lg-6 alert alert-danger"> 
           Username or password is invalid!
           <button type="button" class="close" data-dismiss="alert">&times;</button>
           </div>';
  }
 }
}
}else{
   header("Location: index.php");
}
?>