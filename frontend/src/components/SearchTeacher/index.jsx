import {useState, useEffect, useContext} from 'react';
import {useLocation} from 'react-router-dom';
import { UserContext } from '../../contexts';
import {TeacherProfile} from '../'


export default function searchTeacher() {
    const { userID } = useContext(UserContext);
    const [data, setData] = useState([])
    const location = useLocation();

    const searchTeacherAPI = async() => {
        try {
            const response = await fetch(`http://localhost:3000/api/teacher/${userID}/details`);
            const result = await response.json();
            console.log(result, "<<<<<<") 
            setData(result);           
            
        } catch (error) {
            console.log(error)
        }
    }

    useEffect(() =>{
      searchTeacherAPI()
    },[])

  return (
    !location.pathname.includes('/updateTeacherProfile') && <TeacherProfile data={data} />
  )
}
