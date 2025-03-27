import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'

import { Education } from './../../generated/models/education'
import { useEducationApi } from '../../contexts/EducationApiContext'

import './Educations.css'

function Educations() {
  const navigate = useNavigate()

  const educationsApi = useEducationApi()
  const [educations, setEducations] = useState<Education[]>([])
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    educationsApi
      .getAllEducations()
      .then((response) => {
        setEducations(response.data)
      })
      .catch((err: unknown) => {
        if (err instanceof Error) {
          setError(err.message)
        } else {
          setError('Unknown error')
        }
      })
  }, [educationsApi])

  return (
    <>
      <div className="educations-container">
        <h2>Educations from backend:</h2>
        {error && <p className="error">Error: {error}</p>}
        <ul className="education-list">
          {educations.map((education) => (
            <li key={education.id} className="education-item">
              <div className="education-degree">{education.degree}</div>
              <div className="education-institution">
                {education.institution}
              </div>
            </li>
          ))}
        </ul>
        <button
          type="button"
          onClick={() => {
            navigate('/')
          }}
        >
          Back to Home
        </button>
      </div>
    </>
  )
}

export default Educations
