import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'

import { Job } from './../../generated/models/job'
import { useJobApi } from '../../contexts/JobApiContext'

import './Jobs.css'

function Jobs() {
  const navigate = useNavigate()

  const jobApi = useJobApi()
  const [jobs, setJobs] = useState<Job[]>([])
  const [error, setError] = useState<string | null>(null)

  useEffect(() => {
    jobApi
      .getAllJobs()
      .then((response) => {
        setJobs(response.data)
      })
      .catch((err: unknown) => {
        if (err instanceof Error) {
          setError(err.message)
        } else {
          setError('Unknown error')
        }
      })
  }, [jobApi])

  return (
    <>
      <div className="jobs-container">
        <h2>Jobs from backend:</h2>
        {error && <p className="error">Error: {error}</p>}
        <ul className="job-list">
          {jobs.map((job) => (
            <li key={job.id} className="job-item">
              <div className="job-title">{job.title}</div>
              <div className="job-company">{job.company}</div>
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

export default Jobs
