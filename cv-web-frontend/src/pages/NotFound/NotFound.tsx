import { useNavigate } from 'react-router-dom'

import './NotFound.css'

function NotFound() {
  const navigate = useNavigate()

  return (
    <>
      <h1>404 Not Found</h1>
      <button
        type="button"
        onClick={() => {
          navigate('/')
        }}
      >
        Back to Home
      </button>
    </>
  )
}

export default NotFound
