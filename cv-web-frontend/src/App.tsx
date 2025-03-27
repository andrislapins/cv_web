import { Route, Routes } from 'react-router-dom'

import Home from './pages/Home/Home'
import Jobs from './pages/Jobs/Jobs'
import Educations from './pages/Educations/Educations'
import NotFound from './pages/NotFound/NotFound'

import { jobApi, educationApi } from './api'
import { JobApiContext } from './contexts/JobApiContext'
import { EducationApiContext } from './contexts/EducationApiContext'

import './App.css'

function App() {
  return (
    <>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route
          path="/jobs"
          element={
            <JobApiContext value={jobApi}>
              <Jobs />
            </JobApiContext>
          }
        />
        <Route
          path="/educations"
          element={
            <EducationApiContext value={educationApi}>
              <Educations />
            </EducationApiContext>
          }
        />
        <Route path="*" element={<NotFound />} />
      </Routes>
    </>
  )
}

export default App
