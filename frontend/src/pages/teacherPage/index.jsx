import {TeacherProfile, SearchTeacher, Greetings} from '../../components'
import {useState, useEffect, useContext} from 'react';
import {useNavigate} from 'react-router-dom';
import { UserContext } from '../../contexts';

export default function searchTeacher() {

  return (
    <>
        <Greetings />
        <SearchTeacher />
    </>
  )
}
