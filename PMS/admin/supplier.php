<!-- PHP code to fetch supplier information -->
<?php
// Database connection parameters
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "pms";

// Create connection
$conn = new mysqli($servername, $username, $password, $dbname);

// echo "connection was successful";
                      
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Fetch supplier information
$sql = "SELECT * FROM supplier"; 
$result = $conn->query($sql);

// Check if query was successful
if ($result === false) {
    die("Error: " . $conn->error);
}
?>
<!DOCTYPE html>
<html lang="en">
<?php include 'include/header.php'; ?>

<body class="nav-md">
  <?php include 'include/sidebar.php'; ?>
  <?php include 'include/menufooter.php'; ?>
  </div>
  </div>

  <?php include 'include/topnav.php'; ?>

  <!-- page content -->
  <div class="right_col" role="main">
    <div class="">
      <div class="page-title">
        <div class="title_left">
          <h3><i class="fa fa-truck"></i> Supplier</h3>
        </div>
      </div>

      <div class="clearfix"></div>

      <div class="row">
        <div class="col-md-12 col-sm-12  ">
          <div class="x_panel">
            <div class="x_title">
              <h2>List of Suppliers</h2>
              <ul class="nav navbar-right panel_toolbox">
                <a href="add-supplier.php" class="btn btn-sm btn-info text-white"><i class="fa fa-plus"></i> Add Supplier</a>
              </ul>
              <div class="clearfix"></div>
            </div>
            <div class="x_content">
              <table id="datatable" class="table table-striped table-bordered" style="width:100%">
                <thead>
                  <tr>
                    <th>ID</th>
                    <th>Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Action</th>
                  </tr>
                </thead>


                <tbody>

                  <?php
                  // Process result
                  if ($result->num_rows > 0) {
                    // Output data of each row
                    while ($row = $result->fetch_assoc()) {
                      echo "<tr>";
                      echo "<td>" . $row["ID"] . "</td>";
                      echo "<td>" . $row["Name"] . "</td>";
                      echo "<td>" . $row["Email"] . "</td>";
                      echo "<td>" . $row["Phone"] . "</td>";
                      echo "<td>" . $row["Address"] . "</td>";
                      echo '<td>
                    <a class="btn btn-sm btn-success text-white"><i class="fa fa-edit"></i> edit</a>
                    <a class="btn btn-sm btn-danger text-white"><i class="fa fa-trash"></i> delete</a>
                  </td>';
                      echo "</tr>";
                    }
                  } else {
                    echo "<tr><td colspan='5'>0 results</td></tr>";
                  }

                  // Close database connection
                  $conn->close();
                  ?>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
  </div>
  </div>

  <?php include 'include/footer.php'; ?>
</body>

</html>