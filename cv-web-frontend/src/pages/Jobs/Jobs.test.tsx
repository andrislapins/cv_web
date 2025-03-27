import { render, screen } from '@testing-library/react'
import { describe, it, expect } from 'vitest'
import { MemoryRouter } from 'react-router-dom'
import { AxiosHeaders, type AxiosResponse } from 'axios'

import { JobApiContext } from '../../contexts/JobApiContext'
import { JobControllerApi } from '../../generated/apis/job-controller-api'

import Jobs from './Jobs'
import { Job } from '../../generated'

const jobsMock: Job[] = [
  { id: 1, title: 'DevOps Engineer', company: 'ACME Corp' },
  { id: 2, title: 'Frontend Developer', company: 'Reactify' },
]

function createAxiosResponse<T>(data: T): AxiosResponse<T> {
  return {
    data,
    status: 200,
    statusText: 'OK',
    headers: {},
    config: {
      headers: new AxiosHeaders(),
    },
  }
}

const mockJobApiPartial: Partial<JobControllerApi> = {
  getAllJobs: () => Promise.resolve(createAxiosResponse(jobsMock)),
}

const mockJobApi = mockJobApiPartial as JobControllerApi
describe('Jobs Page', () => {
  it('renders list of jobs from mock API', async () => {
    render(
      <MemoryRouter>
        <JobApiContext value={mockJobApi}>
          <Jobs />
        </JobApiContext>
      </MemoryRouter>,
    )

    expect(await screen.findByText('DevOps Engineer')).toBeInTheDocument()
    expect(await screen.findByText('Frontend Developer')).toBeInTheDocument()
  })
})
