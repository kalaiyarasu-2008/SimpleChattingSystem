<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ChatFlow - Login</title>

    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            min-height: 100vh;

            display: flex;
            justify-content: center;
            align-items: center;

            font-family: Arial, Helvetica, sans-serif;

            background:
                radial-gradient(
                    circle at 20% 20%,
                    #6366f1 0%,
                    transparent 35%
                ),
                radial-gradient(
                    circle at 80% 80%,
                    #06b6d4 0%,
                    transparent 35%
                ),
                linear-gradient(
                    135deg,
                    #0f172a,
                    #1e1b4b
                );

            overflow: hidden;
        }


        /* Animated background circles */

        .circle {
            position: absolute;

            border-radius: 50%;

            filter: blur(2px);

            opacity: 0.35;

            animation: float 8s ease-in-out infinite;
        }

        .circle.one {
            width: 180px;
            height: 180px;

            background: #818cf8;

            top: 10%;
            left: 10%;
        }

        .circle.two {
            width: 250px;
            height: 250px;

            background: #22d3ee;

            bottom: 5%;
            right: 5%;

            animation-delay: 2s;
        }

        .circle.three {
            width: 100px;
            height: 100px;

            background: #c084fc;

            top: 60%;
            left: 20%;

            animation-delay: 4s;
        }


        @keyframes float {

            0%, 100% {
                transform: translateY(0)
                           translateX(0);
            }

            50% {
                transform: translateY(-30px)
                           translateX(20px);
            }
        }


        /* Login card */

        .login-card {

            position: relative;

            width: 400px;

            max-width: 90%;

            padding: 45px 40px;

            border-radius: 24px;

            background: rgba(255, 255, 255, 0.12);

            border: 1px solid rgba(255, 255, 255, 0.2);

            backdrop-filter: blur(20px);

            -webkit-backdrop-filter: blur(20px);

            box-shadow:
                0 25px 60px rgba(0, 0, 0, 0.35);

            color: white;

            animation: cardAppear 0.8s ease;
        }


        @keyframes cardAppear {

            from {
                opacity: 0;
                transform: translateY(40px) scale(0.95);
            }

            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }


        /* Logo */

        .logo {

            width: 75px;
            height: 75px;

            margin: 0 auto 20px;

            display: flex;
            align-items: center;
            justify-content: center;

            border-radius: 22px;

            background:
                linear-gradient(
                    135deg,
                    #6366f1,
                    #06b6d4
                );

            font-size: 36px;

            box-shadow:
                0 10px 30px rgba(99, 102, 241, 0.45);

            animation: pulse 2.5s infinite;
        }


        @keyframes pulse {

            0%, 100% {
                transform: scale(1);
            }

            50% {
                transform: scale(1.06);
            }
        }


        h1 {

            text-align: center;

            font-size: 30px;

            margin-bottom: 8px;
        }


        .subtitle {

            text-align: center;

            color: #cbd5e1;

            margin-bottom: 30px;

            font-size: 14px;
        }


        /* Error */

        .error {

            padding: 12px;

            margin-bottom: 18px;

            border-radius: 10px;

            background: rgba(239, 68, 68, 0.2);

            border: 1px solid rgba(239, 68, 68, 0.5);

            color: #fecaca;

            text-align: center;

            font-size: 14px;
        }


        /* Input */

        .input-group {

            position: relative;

            margin-bottom: 20px;
        }


        .input-group input {

            width: 100%;

            padding: 15px 16px;

            border: 1px solid rgba(255,255,255,0.2);

            border-radius: 12px;

            outline: none;

            background: rgba(255,255,255,0.1);

            color: white;

            font-size: 15px;

            transition: 0.3s;
        }


        .input-group input::placeholder {

            color: #cbd5e1;
        }


        .input-group input:focus {

            border-color: #818cf8;

            background: rgba(255,255,255,0.15);

            box-shadow:
                0 0 0 4px rgba(129,140,248,0.15);
        }


        /* Login button */

        .login-btn {

            width: 100%;

            padding: 15px;

            border: none;

            border-radius: 12px;

            background:
                linear-gradient(
                    135deg,
                    #6366f1,
                    #06b6d4
                );

            color: white;

            font-size: 16px;

            font-weight: bold;

            cursor: pointer;

            transition: 0.3s;

            box-shadow:
                0 10px 25px rgba(6,182,212,0.25);
        }


        .login-btn:hover {

            transform: translateY(-3px);

            box-shadow:
                0 15px 35px rgba(6,182,212,0.4);
        }


        .login-btn:active {

            transform: scale(0.97);
        }


        .footer {

            text-align: center;

            margin-top: 25px;

            font-size: 12px;

            color: #94a3b8;
        }

    </style>

</head>


<body>

    <div class="circle one"></div>
    <div class="circle two"></div>
    <div class="circle three"></div>


    <div class="login-card">

        <div class="logo">
            💬
        </div>


        <h1>Welcome Back</h1>

        <div class="subtitle">
            Sign in to continue chatting
        </div>


        <%
            String error = request.getParameter("error");

            if (error != null) {
        %>

            <div class="error">
                <%= error %>
            </div>

        <%
            }
        %>


        <form action="login" method="post">

            <div class="input-group">

                <input
                    type="text"
                    name="username"
                    placeholder="Username"
                    autocomplete="username"
                    required>

            </div>


            <div class="input-group">

                <input
                    type="password"
                    name="password"
                    placeholder="Password"
                    autocomplete="current-password"
                    required>

            </div>


            <button
                type="submit"
                class="login-btn">

                Login →

            </button>

        </form>


        <div class="footer">

            Simple Chatting System • JSP + Servlet + AJAX

        </div>

    </div>

</body>

</html>