<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<html lang="en">
 <head>
  <meta charset="utf-8"/>
  <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
  <title>
   Update Profile Photo - Student Portal
  </title>
  <script src="https://cdn.tailwindcss.com">
  </script>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet"/>
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;500;700&amp;display=swap" rel="stylesheet"/>
 </head>
 <body class="bg-gray-100 font-roboto">
  <header class="bg-blue-600 text-white p-4">
   <div class="container mx-auto flex justify-between items-center">
    <h1 class="text-2xl font-bold">
     Student Portal
    </h1>
    <nav class="flex items-center space-x-4">
     <ul class="flex space-x-4">
      <li>
       <a class="hover:underline" href="CourseListStudent">
        Home
       </a>
      </li>
      <li>
       <a class="hover:underline" href="CourseListStudent">
        Courses
       </a>
      </li>
      <li>
       <a class="hover:underline" href="StudentLogout">
        Logout
       </a>
      </li>
     </ul>
     <div class="flex items-center space-x-2">
      <!-- Display Student Photo -->
      <img alt="Student Photo" class="w-10 h-10 rounded-full" height="40" src="${pageContext.request.contextPath}/student/profilePhoto/${student.id}" width="40"/>
      <!-- Display Student Name -->
      <a class="font-bold hover:underline" href="${pageContext.request.contextPath}/student/profile/${student.id}">
       ${student.userName}
      </a>
     </div>
    </nav>
   </div>
  </header>
  <div class="min-h-screen flex items-center justify-center">
   <div class="bg-white p-8 rounded shadow-md w-full max-w-md">
    <h2 class="text-2xl font-bold mb-6 text-center">
     Update Profile Photo
    </h2>
    <div class="flex justify-center mb-6">
     <img alt="Current profile photo placeholder" class="rounded-full w-32 h-32 object-cover" height="150" src="${pageContext.request.contextPath}/student/profilePhoto/${student.id}" width="150"/>
    </div>
    <form:form action="/M_Learning/student/updatePfPhoto" modelAttribue="student" class="space-y-6" enctype="multipart/form-data" method="post">
     
     <input type="hidden" name="id" value="${student.id}">
     <div>
      <label class="block text-sm font-medium text-gray-700" for="profilePhoto">
       Select a new profile picture:
      </label>
      <input class="mt-1 block w-full px-3 py-2 border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm" id="profilePhoto" name="file" required="required" type="file"/>
     </div>
     <div>
      <button class="w-full bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-blue-500" type="submit">
       <i class="fas fa-upload mr-2">
       </i>
       Upload
      </button>
     </div>
    </form:form>
   </div>
  </div>
  <footer class="bg-blue-600 text-white p-4 mt-8">
   <div class="container mx-auto text-center">
    <p>
     © M Learning. All rights reserved.
    </p>
   </div>
  </footer>
 </body>
</html>
