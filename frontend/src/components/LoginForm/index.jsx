import {useState, useEffect, useContext} from 'react';
import {useNavigate} from 'react-router-dom';
import { UserContext } from '../../contexts';

export default function LoginForm() {

    const navigate = useNavigate() 
    const { setContextUsername } = useContext(UserContext);
    const [username, setUsername] = useState("");
    const [password, setPassword] = useState("");

    
    const handleInputChange = (e) => {
        const {id, value} = e.target

        if(id === "username"){
            setUsername(value);
        }    
        
        if(id === "password"){
            setPassword(value);
        }
    }

    const handleSubmit  = (e) => {
        e.preventDefault();
        loginAPI()
    }

    const loginAPI = async() => {
        try {
            const options = {
                method: "POST",
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                    username: username,
                    password: password
            })}

            const response = await fetch('http://localhost:3000/api/user/login', options);
            const data = await response.json();  

            localStorage.setItem("username", data.username);
            localStorage.setItem("token", data.token);    
            setContextUsername(data.username);      
            navigate("/student")
            
        } catch (error) {
            alert(error)
        }
    }

    return (
        <>
            <form className="Form" onSubmit={handleSubmit}>
                <p>Login</p>
                <div className="username">
                    <label className="form_label" htmlFor="username">Username </label>
                    <input className="form_input" value={username} onChange = {(e) => handleInputChange(e)} name="" type="text" id="username" placeholder="username" required/>       
                </div>                
                <div className="password">
                    <label className="form_label" htmlFor="password">Password </label>
                    <input className="form_input" value={password} onChange = {(e) => handleInputChange(e)} type="password" id="password" placeholder="Password" required/>
                </div>
                
                <div className="submit-button">
                    <button type="submit" className="btn">Login</button>
                </div>                      
            </form>
        </>
    )
}
