<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teacher Registration</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <style>
        body {
            background-image: url('https://corp.kaltura.com/wp-content/uploads/2022/05/5-virtual-classroom-backgrounds-02.png');
            background-size: cover;
            background-position: center;
            font-family: 'Arial', sans-serif;
        }
    </style>
</head>
<body class="flex items-center justify-center min-h-screen bg-gray-900 bg-opacity-50">
    <div class="absolute top-0 left-0 w-full p-4 flex justify-between items-center bg-white bg-opacity-80 shadow-md z-10">
        <div class="text-2xl font-bold text-gray-800">M Learning</div>
        <nav class="space-x-4">
            <a href="${pageContext.request.contextPath}/" class="text-black hover:text-gray-300">Home</a>
            <a href="#" class="text-black hover:text-gray-300">Course</a>
            <a href="#" class="text-black border border-white px-4 py-2 rounded hover:bg-white hover:text-gray-900">Login</a>
        </nav>
    </div>

    <div class="bg-white bg-opacity-80 p-8 rounded-lg shadow-lg max-w-sm w-full">
        <div class="flex justify-between items-center mb-4">
            <h2 class="text-2xl font-bold text-gray-800">Register Teacher</h2>
        </div>
        
        <c:if test="${not empty errorMessage}">
    	<div class="bg-red-500 text-white px-4 py-2 rounded mb-4">
       	 ${errorMessage}
    	</div>
		</c:if>
        

        <form:form action="addTeacher" method="post" modelAttribute="teacherRegister" enctype="multipart/form-data">
            <!-- Username -->
            <div class="mb-4">
                <label for="userName" class="block text-gray-700">UserName</label>
                <form:input path="userName" id="userName" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your name" />
                <form:errors path="userName" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Email -->
            <div class="mb-4">
                <label for="email" class="block text-gray-700">Email</label>
                <form:input path="email" id="email" type="email" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your email" />
                <form:errors path="email" cssClass="text-red-500 text-sm mt-1" />
                <c:if test="${not empty emailError}">
            	<div class="alert alert-danger">${emailError}</div>
        		</c:if>
        		<c:if test="${not empty emailExistsError}">
            	<div class="alert alert-danger">${emailExistsError}</div>
        		</c:if>
        		
            </div>

            <!-- Password -->
            <div class="mb-4">
                <label for="password" class="block text-gray-700">Password</label>
                <form:password path="password" id="password" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter password" />
                <form:errors path="password" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Confirm Password -->
            <div class="mb-4">
                <label for="confirmPassword" class="block text-gray-700">Confirm Password</label>
                <form:password path="confirmPassword" id="confirmPassword" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Confirm your password" />
                <form:errors path="confirmPassword" cssClass="text-red-500 text-sm mt-1" />
                <c:if test="${not empty passwordError}">
            	<div class="alert alert-danger">${passwordError}</div>
        		</c:if>
            </div>
            

            <!-- Subject -->
            <div class="mb-4">
                <label for="subject" class="block text-gray-700">Subject</label>
                <form:input path="subject" id="subject" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your subject" />
                <form:errors path="subject" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Bio -->
            <div class="mb-4">
                <label for="bio" class="block text-gray-700">Bio</label>
                <form:textarea path="bio" id="bio" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Write a brief bio"></form:textarea>
                <form:errors path="bio" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Gender -->
            <div class="mb-4">
                <label class="block text-gray-700">Gender</label>
                <div>
                    <form:radiobutton path="gender" value="Male" /> Male
                    <form:radiobutton path="gender" value="Female" /> Female
                </div>
                <form:errors path="gender" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- City -->
            <div class="mb-4">
                <label for="city" class="block text-gray-700">City</label>
                <form:input path="city" id="city" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your city" />
                <form:errors path="city" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Phone Number -->
            <div class="mb-4">
                <label for="phoneNumber" class="block text-gray-700">Phone Number</label>
                <form:input path="phoneNumber" id="phoneNumber" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your phone number" />
                <form:errors path="phoneNumber" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Profile Photo -->
            <div class="mb-4">
                <label for="profilePhoto" class="block text-gray-700">Profile Photo</label>
                <form:input path="file" id="profilePhoto" type="file" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" />
                <form:errors path="file" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Submit Button -->
            <button type="submit" class="w-full bg-gray-800 text-white py-2 rounded hover:bg-gray-900">Register</button>
        </form:form>

        <p class="mt-4 text-center text-gray-700">Already have an account? <a href="${pageContext.request.contextPath}/teacher/login" class="text-blue-500 hover:underline">Login</a></p>
    </div>
</body>
</html>
