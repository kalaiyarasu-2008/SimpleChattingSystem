<%@ page language="java"
    contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
    String username =
        (String) session.getAttribute("username");

    if (username == null) {

        response.sendRedirect("login.jsp");

        return;
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>ChatFlow</title>


    <style>

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }


        body {

            min-height: 100vh;

            font-family:
                Arial,
                Helvetica,
                sans-serif;

            background:
                linear-gradient(
                    135deg,
                    #eef2ff,
                    #ecfeff
                );

            color: #1e293b;
        }


        /* Main application */

        .app {

            width: 100%;

            height: 100vh;

            display: flex;

            align-items: center;

            justify-content: center;

            padding: 20px;
        }


        .chat-container {

            width: 100%;

            max-width: 1050px;

            height: 90vh;

            display: flex;

            overflow: hidden;

            background: white;

            border-radius: 24px;

            box-shadow:
                0 25px 70px rgba(15,23,42,0.18);

            animation: appear 0.6s ease;
        }


        @keyframes appear {

            from {
                opacity: 0;
                transform: translateY(25px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }


        /* Sidebar */

        .sidebar {

            width: 300px;

            padding: 25px;

            color: white;

            background:
                linear-gradient(
                    160deg,
                    #4f46e5,
                    #0891b2
                );

            display: flex;

            flex-direction: column;
        }


        .brand {

            display: flex;

            align-items: center;

            gap: 12px;

            margin-bottom: 35px;
        }


        .brand-icon {

            width: 48px;
            height: 48px;

            display: flex;

            justify-content: center;
            align-items: center;

            border-radius: 14px;

            background:
                rgba(255,255,255,0.2);

            font-size: 25px;
        }


        .brand h2 {

            font-size: 21px;
        }


        .brand small {

            display: block;

            color: #dbeafe;

            margin-top: 3px;
        }


        .profile {

            padding: 18px;

            border-radius: 18px;

            background:
                rgba(255,255,255,0.12);

            border:
                1px solid rgba(255,255,255,0.18);

            backdrop-filter: blur(10px);

            margin-bottom: 25px;
        }


        .avatar {

            width: 55px;
            height: 55px;

            border-radius: 50%;

            display: flex;

            justify-content: center;
            align-items: center;

            background: white;

            color: #4f46e5;

            font-size: 22px;

            font-weight: bold;

            margin-bottom: 12px;
        }


        .profile-name {

            font-weight: bold;

            font-size: 17px;
        }


        .online {

            margin-top: 6px;

            color: #bbf7d0;

            font-size: 13px;
        }


        .online::before {

            content: "";

            display: inline-block;

            width: 8px;
            height: 8px;

            margin-right: 6px;

            border-radius: 50%;

            background: #22c55e;

            animation: onlinePulse 1.5s infinite;
        }


        @keyframes onlinePulse {

            0%, 100% {
                box-shadow:
                    0 0 0 0
                    rgba(34,197,94,0.6);
            }

            50% {
                box-shadow:
                    0 0 0 6px
                    rgba(34,197,94,0);
            }
        }


        .sidebar-info {

            margin-top: auto;

            color: #dbeafe;

            font-size: 12px;

            line-height: 1.6;
        }


        /* Chat section */

        .chat-section {

            flex: 1;

            display: flex;

            flex-direction: column;

            min-width: 0;
        }


        .chat-header {

            min-height: 85px;

            padding: 18px 25px;

            border-bottom: 1px solid #e2e8f0;

            display: flex;

            align-items: center;

            justify-content: space-between;

            background: white;
        }


        .receiver-area {

            display: flex;

            align-items: center;

            gap: 12px;

            flex: 1;
        }


        .receiver-input {

            width: 100%;

            max-width: 350px;

            padding: 13px 16px;

            border: 1px solid #cbd5e1;

            border-radius: 12px;

            outline: none;

            font-size: 14px;

            transition: 0.3s;

            background: #f8fafc;
        }


        .receiver-input:focus {

            border-color: #6366f1;

            background: white;

            box-shadow:
                0 0 0 4px
                rgba(99,102,241,0.1);
        }


        .status {

            color: #64748b;

            font-size: 13px;
        }


        /* Messages */

        .chat-box {

            flex: 1;

            padding: 25px;

            overflow-y: auto;

            background:
                radial-gradient(
                    circle at top right,
                    #eef2ff,
                    transparent 40%
                ),
                #f8fafc;
        }


        .empty {

            height: 100%;

            display: flex;

            flex-direction: column;

            justify-content: center;

            align-items: center;

            color: #94a3b8;

            text-align: center;
        }


        .empty-icon {

            font-size: 55px;

            margin-bottom: 15px;

            animation: floating 3s infinite;
        }


        @keyframes floating {

            0%, 100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-10px);
            }
        }


        .message {

            max-width: 70%;

            margin-bottom: 15px;

            padding: 13px 16px;

            border-radius: 18px;

            background: white;

            border: 1px solid #e2e8f0;

            box-shadow:
                0 5px 15px
                rgba(15,23,42,0.06);

            animation: messageIn 0.35s ease;
        }


        @keyframes messageIn {

            from {
                opacity: 0;
                transform: translateY(10px) scale(0.98);
            }

            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }


        .message.mine {

            margin-left: auto;

            background:
                linear-gradient(
                    135deg,
                    #6366f1,
                    #4f46e5
                );

            color: white;

            border: none;

            border-bottom-right-radius: 5px;
        }


        .message.other {

            margin-right: auto;

            border-bottom-left-radius: 5px;
        }


        .message-header {

            font-size: 11px;

            font-weight: bold;

            margin-bottom: 6px;

            opacity: 0.7;
        }


        .message-text {

            font-size: 15px;

            line-height: 1.5;

            white-space: pre-wrap;

            overflow-wrap: anywhere;
        }


        .message-time {

            font-size: 10px;

            margin-top: 7px;

            opacity: 0.6;

            text-align: right;
        }


        /* Send area */

        .send-section {

            padding: 18px 22px;

            display: flex;

            gap: 12px;

            border-top: 1px solid #e2e8f0;

            background: white;
        }


        .message-input {

            flex: 1;

            padding: 14px 17px;

            border: 1px solid #cbd5e1;

            border-radius: 14px;

            outline: none;

            font-size: 15px;

            transition: 0.3s;
        }


        .message-input:focus {

            border-color: #6366f1;

            box-shadow:
                0 0 0 4px
                rgba(99,102,241,0.1);
        }


        .send-button {

            width: 55px;
            height: 50px;

            border: none;

            border-radius: 14px;

            color: white;

            background:
                linear-gradient(
                    135deg,
                    #6366f1,
                    #06b6d4
                );

            font-size: 20px;

            cursor: pointer;

            transition: 0.25s;

            box-shadow:
                0 8px 20px
                rgba(99,102,241,0.25);
        }


        .send-button:hover {

            transform:
                translateY(-3px)
                rotate(-3deg);

            box-shadow:
                0 12px 25px
                rgba(99,102,241,0.35);
        }


        .send-button:active {

            transform: scale(0.92);
        }


        /* Scrollbar */

        .chat-box::-webkit-scrollbar {

            width: 7px;
        }


        .chat-box::-webkit-scrollbar-thumb {

            background: #cbd5e1;

            border-radius: 10px;
        }


        /* Mobile */

        @media (max-width: 700px) {

            .app {

                padding: 0;
            }


            .chat-container {

                height: 100vh;

                border-radius: 0;
            }


            .sidebar {

                display: none;
            }


            .chat-header {

                padding: 15px;
            }


            .chat-box {

                padding: 15px;
            }


            .message {

                max-width: 85%;
            }

        }

    </style>

</head>


<body>


<div class="app">


    <div class="chat-container">


        <!-- SIDEBAR -->

        <aside class="sidebar">


            <div class="brand">

                <div class="brand-icon">
                    💬
                </div>

                <div>

                    <h2>ChatFlow</h2>

                    <small>
                        Simple Chat System
                    </small>

                </div>

            </div>


            <div class="profile">

                <div class="avatar">

                    <%= username.substring(0,1).toUpperCase() %>

                </div>

                <div class="profile-name">

                    <%= username %>

                </div>

                <div class="online">

                    Online

                </div>

            </div>


            <div class="sidebar-info">

                Your messages are stored securely
                in the database.

                <br><br>

                AJAX powered messaging
                without page refresh.

            </div>

        </aside>


        <!-- CHAT -->

        <main class="chat-section">


            <header class="chat-header">


                <div class="receiver-area">

                    <input
                        type="text"
                        id="receiver"
                        class="receiver-input"
                        placeholder="Enter username to chat..."
                        autocomplete="off">

                </div>


                <div
                    id="status"
                    class="status">

                    Ready

                </div>


            </header>


            <div
                id="chatBox"
                class="chat-box">


                <div class="empty">

                    <div class="empty-icon">
                        💬
                    </div>

                    <h3>
                        Start a conversation
                    </h3>

                    <p>
                        Enter a username above
                        to view your messages.
                    </p>

                </div>


            </div>


            <div class="send-section">


                <input
                    type="text"
                    id="message"
                    class="message-input"
                    placeholder="Type a message..."
                    autocomplete="off">


                <button
                    id="sendButton"
                    class="send-button"
                    onclick="sendMessage()">

                    ➤

                </button>


            </div>


        </main>


    </div>

</div>


<script>


    const currentUser =
        document
            .getElementById("currentUser")
            ?.textContent
            .trim();


    function loadMessages() {


        const receiver =
            document
                .getElementById("receiver")
                .value
                .trim();


        const chatBox =
            document.getElementById("chatBox");


        if (receiver === "") {

            return;
        }


        fetch(
            "chat?receiver=" +
            encodeURIComponent(receiver)
        )

        .then(response => {

            if (!response.ok) {

                throw new Error(
                    "HTTP " +
                    response.status
                );
            }

            return response.json();
        })


        .then(messages => {


            chatBox.innerHTML = "";


            if (messages.length === 0) {

                chatBox.innerHTML = `

                    <div class="empty">

                        <div class="empty-icon">
                            💬
                        </div>

                        <h3>
                            No messages yet
                        </h3>

                        <p>
                            Send the first message!
                        </p>

                    </div>

                `;

                return;
            }


            messages.forEach(msg => {


                const messageDiv =
                    document.createElement("div");


                messageDiv.className =
                    "message " +
                    (
                        msg.sender === currentUser
                        ? "mine"
                        : "other"
                    );


                const header =
                    document.createElement("div");

                header.className =
                    "message-header";

                header.textContent =
                    msg.sender;


                const text =
                    document.createElement("div");

                text.className =
                    "message-text";

                text.textContent =
                    msg.message;


                const time =
                    document.createElement("div");

                time.className =
                    "message-time";

                time.textContent =
                    msg.time;


                messageDiv.appendChild(header);

                messageDiv.appendChild(text);

                messageDiv.appendChild(time);


                chatBox.appendChild(messageDiv);

            });


            chatBox.scrollTop =
                chatBox.scrollHeight;


        })

        .catch(error => {

            console.error(
                "Loading error:",
                error
            );

        });

    }


    function sendMessage() {


        const receiver =
            document
                .getElementById("receiver")
                .value
                .trim();


        const message =
            document
                .getElementById("message")
                .value
                .trim();


        if (receiver === "") {

            alert(
                "Please enter a receiver username."
            );

            return;
        }


        if (message === "") {

            return;
        }


        const data =
            new URLSearchParams();


        data.append(
            "receiver",
            receiver
        );


        data.append(
            "message",
            message
        );


        const button =
            document.getElementById(
                "sendButton"
            );


        button.disabled = true;

        button.textContent = "…";


        fetch("chat", {

            method: "POST",

            headers: {

                "Content-Type":
                    "application/x-www-form-urlencoded"

            },

            body:
                data.toString()

        })


        .then(response =>
            response.text()
        )


        .then(result => {


            if (result === "success") {


                document
                    .getElementById("message")
                    .value = "";


                loadMessages();


            } else {

                alert(result);

            }

        })


        .catch(error => {

            console.error(
                "Send error:",
                error
            );

            alert(
                "Unable to send message."
            );

        })


        .finally(() => {

            button.disabled = false;

            button.textContent = "➤";

        });

    }


    document
        .getElementById("receiver")
        .addEventListener(
            "input",
            loadMessages
        );


    document
        .getElementById("message")
        .addEventListener(
            "keydown",
            function(event) {

                if (event.key === "Enter") {

                    event.preventDefault();

                    sendMessage();

                }

            }
        );


    // Automatically refresh messages
    // every 2 seconds.

    setInterval(
        loadMessages,
        2000
    );


</script>


</body>

</html>