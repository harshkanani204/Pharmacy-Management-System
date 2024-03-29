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
$sql = "SELECT * FROM medicine"; 
$result = $conn->query($sql);

// Check if query was successful
if ($result === false) {
    die("Error: " . $conn->error);
}
?>
<!DOCTYPE html>
<html lang="en">
<?php include 'include/header.php';?>

  <body class="nav-md">
            <?php include 'include/sidebar.php';?>
            <?php include 'include/menufooter.php';?>
          </div>
        </div>

        <?php include 'include/topnav.php';?>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3><i class="fa fa-medkit"></i> Medicine</h3>
              </div>
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>List of Medicines</h2>
                    <ul class="nav navbar-right panel_toolbox">
                    <a href="add-medicine.php" class="btn btn-sm btn-info text-white"><i class="fa fa-plus"></i> Add Medicine</a>
                    </ul>
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                  <table id="datatable" class="table table-striped table-bordered" style="width:100%">
                      <thead>
                        <tr>
                          <th> ID</th>
                          <th>Name</th>
                          <th>Quantity</th>
                          <th>Unit_Price</th>
                          <th>Expiration_Date</th>
                          <th>Action</th>
                        </tr>
                      </thead>


                      <tbody>
                        <?php
                          if ($result->num_rows > 0) {
                    // Output data of each row
                    while ($row = $result->fetch_assoc()) {
                      echo "<tr>";
                      echo "<td>" . $row["ID"] . "</td>";
                      echo "<td>" . $row["Name"] . "</td>";
                      echo "<td>" . $row["Quantity"] . "</td>";
                      echo "<td>" . $row["Unit_Price"] . "</td>";
                      echo "<td>" . $row["Expiration_Date"] . "</td>";
                      echo '<td>
                              <a class="btn btn-sm btn-info text-white"><i class="fa fa-eye"></i> details</a>
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
                        </tr>

                        <!-- <tr>
                          <td>MDCN-101</td>
                          <td><img src="images/alaxan.png" width="50" style="border-radius:10px" alt="Image"></td>
                          <td>Tuseran</td>
                          <td>Php8.00</td>
                          <td>Php10.00</td>
                          <td>100</td>
                          <td>pcs</td>
                          <td>
                              <a class="btn btn-sm btn-info text-white"><i class="fa fa-eye"></i> details</a>
                              <a class="btn btn-sm btn-success text-white"><i class="fa fa-edit"></i> edit</a>
                              <a class="btn btn-sm btn-danger text-white"><i class="fa fa-trash"></i> delete</a>
                          </td>
                        </tr>
                        <tr>
                          <td>MDCN-234</td>
                          <td><img src="images/alaxan.png" width="50" style="border-radius:10px" alt="Image"></td>
                          <td>BioFlu</td>
                          <td>Php7.00</td>
                          <td>Php12.00</td>
                          <td>120</td>
                          <td>pcs</td>
                          <td>
                              <a class="btn btn-sm btn-info text-white"><i class="fa fa-eye"></i> details</a>
                              <a class="btn btn-sm btn-success text-white"><i class="fa fa-edit"></i> edit</a>
                              <a class="btn btn-sm btn-danger text-white"><i class="fa fa-trash"></i> delete</a>
                          </td>
                        </tr>
                        <tr>
                          <td>MDCN-454</td>
                          <td><img src="images/alaxan.png" width="50" style="border-radius:10px" alt="Image"></td>
                          <td>Neozep</td>
                          <td>Php5.00</td>
                          <td>Php7.00</td>
                          <td>200</td>
                          <td>pcs</td>
                          <td>
                              <a class="btn btn-sm btn-info text-white"><i class="fa fa-eye"></i> details</a>
                              <a class="btn btn-sm btn-success text-white"><i class="fa fa-edit"></i> edit</a>
                              <a class="btn btn-sm btn-danger text-white"><i class="fa fa-trash"></i> delete</a>
                          </td>
                        </tr>
                        <tr>
                          <td>MDCN-122</td>
                          <td><img src="images/alaxan.png" width="50" style="border-radius:10px" alt="Image"></td>
                          <td>Alaxan</td>
                          <td>Php8.00</td>
                          <td>Php10.00</td>
                          <td>30</td>
                          <td>box</td>
                          <td>
                              <a class="btn btn-sm btn-info text-white"><i class="fa fa-eye"></i> details</a>
                              <a class="btn btn-sm btn-success text-white"><i class="fa fa-edit"></i> edit</a>
                              <a class="btn btn-sm btn-danger text-white"><i class="fa fa-trash"></i> delete</a>
                          </td>
                        </tr>
                        <tr>
                          <td>MDCN-675</td>
                          <td><img src="images/alaxan.png" width="50" style="border-radius:10px" alt="Image"></td>
                          <td>Biogesic</td>
                          <td>Php5.00</td>
                          <td>Php8.00</td>
                          <td>20</td>
                          <td>box</td>
                          <td>
                              <a class="btn btn-sm btn-info text-white"><i class="fa fa-eye"></i> details</a>
                              <a class="btn btn-sm btn-success text-white"><i class="fa fa-edit"></i> edit</a>
                              <a class="btn btn-sm btn-danger text-white"><i class="fa fa-trash"></i> delete</a>
                          </td> -->
                        </tr>
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

    <?php include 'include/footer.php';?>
  </body>
</html>
