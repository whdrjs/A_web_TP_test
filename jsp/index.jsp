<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
     <meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="jk">

    <title>Gachon Study Maker</title>

    <!-- Bootstrap core CSS -->
    <link href="vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom fonts for this template -->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet">
    <link href="vendor/simple-line-icons/css/simple-line-icons.css" rel="stylesheet" type="text/css">
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    <!-- Custom styles for this template -->
    <link href="css/landing-page.min.css" rel="stylesheet">  
  </head>

  <body style="background-color:#F8F9FA;">
 
    <!-- Navigation -->
    <nav class="navbar navbar-light bg-light static-top" style="margin: 15px 1px 15px 1px;">
      <div class="container">
        <a class="navbar-brand" href="index.jsp">Gachon Study Maker</a>
        <a class="btn btn-primary" href="create.jsp">Make New study</a>
      </div>
    </nav>

    <!-- Search Study -->
    
    <div class="container">
      <div class="row" style="margin: 60px 1px 50px 1px;" >
        <div class="col-md-10 col-lg-8 col-xl-9 mx-auto">
          <form action="search.jsp">
            <div class="form-row">
              <div class="col-12 col-md-9 mb-3 mb-md-0">
                <input type="text" name="search" class="form-control form-control-lg" placeholder="Search to Study...">
              </div>
              <div style="margin: auto;" class="col-4 col-md-3">
                <input type="submit" value="Search" class="btn btn-block btn-lg btn-primary"/>
              </div>
            </div>
          </form>
        </div>
      </div>
      
      <!-- Study List -->
      <h3 class="my-4">Study Group
        <small>  List of study groups</small>
      </h3>

      <div class="row" id="target">
      
      </div> 
      <!-- /.row -->
      <br/>
      
      <!-- Pagination -->
      <ul class="pagination justify-content-center">
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Previous">
            <span aria-hidden="true">&laquo;</span>
            <span class="sr-only">Previous</span>
          </a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">1</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">2</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#">3</a>
        </li>
        <li class="page-item">
          <a class="page-link" href="#" aria-label="Next">
            <span aria-hidden="true">&raquo;</span>
            <span class="sr-only">Next</span>
          </a>
        </li>
      </ul>

    </div>
    <!-- Footer -->
    <footer class="footer bg-light">
      <div class="container">
        <div class="row">
          <div class="col-lg-6 h-100 text-center text-lg-left my-auto">
            <ul class="list-inline mb-2">
              <li class="list-inline-item">
                <a href="#">About</a>
              </li>
              <li class="list-inline-item">&sdot;</li>
              <li class="list-inline-item">
                <a href="#">Contact</a>
              </li>
              <li class="list-inline-item">&sdot;</li>
              <li class="list-inline-item">
                <a href="#">Terms of Use</a>
              </li>
              <li class="list-inline-item">&sdot;</li>
              <li class="list-inline-item">
                <a href="#">Privacy Policy</a>
              </li>
            </ul>
            <p class="text-muted small mb-4 mb-lg-0">&copy; Your Website 2018. All Rights Reserved.</p>
          </div>
          <div class="col-lg-6 h-100 text-center text-lg-right my-auto">
            <ul class="list-inline mb-0">
              <li class="list-inline-item mr-3">
                <a href="#">
                  <i class="fab fa-facebook fa-2x fa-fw"></i>
                </a>
              </li>
              <li class="list-inline-item mr-3">
                <a href="#">
                  <i class="fab fa-twitter-square fa-2x fa-fw"></i>
                </a>
              </li>
              <li class="list-inline-item">
                <a href="#">
                  <i class="fab fa-instagram fa-2x fa-fw"></i>
                </a>
              </li>
            </ul>
          </div>
        </div>
      </div>
    </footer>

    <!-- Bootstrap core JavaScript -->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

   <!-- Firebase -->

<script src="https://www.gstatic.com/firebasejs/5.5.9/firebase.js"></script>
<script>
  // Initialize Firebase
  var config = {
    apiKey: "AIzaSyBWxWPMx03teCUuLwG0db4Ay9xuXnm39V0",
    authDomain: "gachonstudymaker.firebaseapp.com",
    databaseURL: "https://gachonstudymaker.firebaseio.com",
    projectId: "gachonstudymaker",
    storageBucket: "gachonstudymaker.appspot.com",
    messagingSenderId: "490179660109"
  };
  firebase.initializeApp(config);
</script>
  
  <script>
  var auth = firebase.auth();
  var authProvider = new firebase.auth.GoogleAuthProvider();
  var database = firebase.database();
   
  auth.onAuthStateChanged(function(user){
     if(user){
        console.log("success");
        get_study_list();
     }
     else
     {
       auth.signInWithPopup(authProvider);
     }
  });
  
  function get_study_list(){
     var studyRef = database.ref('study/');
     studyRef.on('child_added',on_child_added);
  }
  
  function on_child_added(data){    
     var key=data.key;
     var studyData=data.val();
     var title = studyData.title;
     var content = studyData.content;
     var studyID = studyData.studyID;
     var html="<div class=\"col-lg-3 col-md-4 col-sm-6 portfolio-item\">"
      +"<div class=\"card h-30\"><a href=\"detail.jsp?title="+title+" &content="+content+" &key="+key+"\"><img class=\"card-img-top\" src=\"https://source.unsplash.com/350x200/?"+title+"\" alt=\"\"></a>"
            +"<div class=\"card-body\"><h4 class=\"card-title\">"
            +"<a href=\"detail.jsp?title="+title+" &content="+content+" &key="+key+"\">"+title+"</a></h4>"
             + "<p class=\"card-text\">"+content+"</p></div></div></div>"
   
     $("#target").append(html);
  }

 //add new study
  <%String title = request.getParameter("title");%> 
  <%String content = request.getParameter("content");%> 
  
  <%if((title !=null) && (content!=null))
  {%>
     <%if(!(title.trim().equals("")) && !(content.trim().equals("")))
     {%>
        database.ref('study/').push({"studyID" : "-1", "title": "<%=title%>", "content": "<%=content%>", "close_date" : "20181204", "open_date" : "20180909", "memberNum": 13});
     <%}%>  
  <%}%>
  
 
</script>

</body>

</html>