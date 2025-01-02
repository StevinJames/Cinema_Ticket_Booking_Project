<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Registration</title>
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
            <h2 class="text-2xl font-bold text-gray-800">Register Admin</h2>
        </div>

        <c:if test="${not empty errorMessage}">
            <div class="bg-red-500 text-white px-4 py-2 rounded mb-4">
                ${errorMessage}
            </div>
        </c:if>

        <form:form action="addAdmin" method="post" modelAttribute="adminRegistration">
            <!-- Username -->
            <div class="mb-4">
                <label for="userName" class="block text-gray-700">Username</label>
                <form:input path="userName" id="userName" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your username" />
                <form:errors path="userName" cssClass="text-red-500 text-sm mt-1" />
            </div>

            <!-- Email -->
            <div class="mb-4">
                <label for="email" class="block text-gray-700">Email</label>
                <form:input path="email" id="email" type="email" class="w-full px-4 py-2 border rounded focus:outline-none focus:ring-2 focus:ring-blue-500" placeholder="Enter your email" />
                <form:errors path="email" cssClass="text-red-500 text-sm mt-1" />
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
            </div>

            <!-- Submit Button -->
            <button type="submit" class="w-full bg-gray-800 text-white py-2 rounded hover:bg-gray-900">Register</button>
        </form:form>

        <p class="mt-4 text-center text-gray-700">Already have an account? <a href="${pageContext.request.contextPath}/admin/login" class="text-blue-500 hover:underline">Login</a></p>
    </div>
</body>
</html>
