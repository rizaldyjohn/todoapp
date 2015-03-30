require 'rails_helper'

RSpec.describe 'list of tasks', type: :feature do
	describe 'GET /dashboard' do

    pending 'Guests should not access this page'

		it 'should allow the user visit task' do
  		visit dashboard_root_path
  		expect(page).to have_content('Task')
      visit dashboard_tasks_path
      expect(page).to have_content('New task')
  	end

    context 'allows user to create task and validate empty fields' do
      it 'it should validate the user if the fields is empty' do
        visit new_dashboard_task_path
        expect(page).to have_content('New Task')

        within('form') do
          fill_in 'task_title', with: ' '
          fill_in 'task_description', with: ' '
        end

        expect(page).to have_content('Yes')
        expect(page).to have_content('No')
        click_button 'Create Task'
        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Description can't be blank")
      end

      it 'should allow user to create new task' do
        visit new_dashboard_task_path
        expect(page).to have_content('New Task')

        within('form') do
          fill_in 'task_title', with: ' '
          fill_in 'task_description', with: ' '
        end

        expect(page).to have_content('Yes')
        expect(page).to have_content('No')
        click_button 'Create Task'
      end
    end

    context 'when user is done creating a task' do
      it 'sould show the task created' do
        visit  dashboard_tasks_path
        expect(page).to have_content('Listing tasks')
        expect(page).to have_content('Title')
        expect(page).to have_content('Description')
        expect(page).to have_content('Completed')
      end

      it 'should allow the user to visit edit' do
       visit edit_dashboard_task_path
       expect(page).to have_content('Editing task')
       expect(page).to have_content('Update Task')
     end
    end

    pending 'when user will delete a task'
    #   pending  context 'when user will delete a task' do
    #    it 'should allow the user to delete a task' do
    #     expect { delete :destroy, id: dashboard_task  }
    #   end
    #    it 'should let user cancel destroying a task' do
    #     expect {}
    #   end
    # end
  end
end
