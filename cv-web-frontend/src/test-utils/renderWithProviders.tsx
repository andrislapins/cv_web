import { ReactNode } from 'react'
import { render } from '@testing-library/react'
import { MemoryRouter } from 'react-router-dom'
import { JobApiContext } from '../contexts/JobApiContext'
import { EducationApiContext } from '../contexts/EducationApiContext'
import { mockJobApi, mockEducationApi } from './apiMocks'

export function renderWithProviders(ui: ReactNode, { route = '/' } = {}) {
  return render(
    <MemoryRouter
      initialEntries={[route]}
      future={{ v7_startTransition: true, v7_relativeSplatPath: true }}
    >
      <JobApiContext value={mockJobApi}>
        <EducationApiContext value={mockEducationApi}>{ui}</EducationApiContext>
      </JobApiContext>
    </MemoryRouter>,
  )
}
