<?php
  class Star {
    public $starID;
    public $constellation;
    public $name;
    public $distance;
    public $price;

    private $conn;

    public function __construct($db) {
      $this->conn = $db;
    }

    public function getAllUsers() {
      $stmt = $this->conn->prepare('SELECT * FROM STAR');
      $stmt->execute();
      $result = $stmt->get_result();
      return $result;
    }

    public function getStar() {
      $stmt = $this->conn->prepare('SELECT  * FROM STAR WHERE idStella = ?');
      $stmt->bind_param('s', $this->starID);
      $stmt->execute();
      $result = $stmt->get_result();
      if($result->num_rows > 0) {
        $row = $result->fetch_assoc();
        extract($row);
        $this->userID = $userID;
        $this->role = $role;
        $this->email = $email;
        $this->pwd = $pwd;
        $this->username = $username;
        $this->firstName = $firstName;
        $this->lastName = $lastName;
        $this->img = $img;
        return TRUE;
      }
      return FALSE;
    }

    public function insertStar() {
      $stmt = $this->conn->prepare('INSERT INTO STAR SET email = ?, pwd = ?, username = ?, firstName = ?, lastName = ?, img = ?');
      $stmt->bind_param('ssssss', $this->email, $this->pwd, $this->username, $this->firstName, $this->lastName, $this->img);
      if($stmt->execute()) return TRUE;
      return FALSE;
    }

    public function updateStar() {
    $stmt = $this->conn->prepare('UPDATE STAR SET pwd = ?, username = ?, firstName = ?, lastName = ?, img = ? WHERE email = ?');
      $stmt->bind_param('ssssss', $this->pwd, $this->username, $this->firstName, $this->lastName, $this->img, $this->email);
      if($stmt->execute()) return TRUE;
      return FALSE;
    }

    public function deleteStar() {
      $stmt = $this->conn->prepare('DELETE FROM STAR WHERE email = ?');
      $stmt->bind_param('s', $this->email);
      if($stmt->execute()) return TRUE;
      return FALSE;
    }

    public function printStar() {
      print_r(json_encode(array(
        'userID' => $this->userID,
        'role' => $this->role,
        'email' => $this->email,
        'pwd' => $this->pwd,
        'username' => $this->username,
        'firstName' => $this->firstName,
        'lastName' => $this->lastName,
        'img' => $this->img
      )));
    }
  }
?>
