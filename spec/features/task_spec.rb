require 'rails_helper'
 
RSpec.describe 'list of tasks', type: :feature do
  describe 'GET /dashboard/tasks' do
 
#    it 'should not allow guest user to visit task dashboard' do
#      visit dashboard_root_path    
#    end
 
    before :each do
      sarah_smith = FactoryGirl.create(:user, email: 'abc1@yopmail.com', password: 'testing')
      visit root_path
      click_link 'Sign in'

        fill_in 'email', with: sarah_smith.email
        fill_in 'password', with: sarah_smith.password 

      click_button 'Sign in'
      expect(page).to have_content('Signed in successfully')
    end 

      it 'should allow the user to visit task dashboard' do
        visit dashboard_root_path
        expect(page).to have_content('Task')
      end
 
      it 'should redirect the user to Listing task' do
        visit dashboard_tasks_path
        expect(page).to have_content('New task')
      end

      it 'it should validate the user if the fields is empty' do
        visit new_dashboard_task_path
        expect(page).to have_content('New Task')
 
          fill_in 'task_title', with: ' '
          fill_in 'task_description', with: ' '
 
        click_button 'Create Task'
        expect(page).to have_content("Title can't be blank")
        expect(page).to have_content("Description can't be blank")
      end
    
    context 'when user create, view and edit a task' do
      it 'should allow user to create new task' do
        visit new_dashboard_task_path
        expect(page).to have_content('New Task')
 
          fill_in 'task_title', with: 'abc1'
          fill_in 'task_description', with: 'abc2'
        
        click_button 'Create Task'
      end

      it 'should show the task created' do
        visit  dashboard_tasks_path
        
        expect(page).to have_content('Listing tasks')
        expect(page).to have_content('Title')
        expect(page).to have_content('Description')
        expect(page).to have_content('Completed')
      end

      it 'should allow the user to edit a task' do
        visit new_dashboard_task_path
        expect(page).to have_content('New Task')

          fill_in 'task_title', with: 'abc1'
          fill_in 'task_description', with: 'abc2'

        click_button 'Create Task'

        click_link 'Edit'
        fill_in 'task_title', with: 'abc3'
        fill_in 'task_description', with: 'abc4'

        click_button 'Update Task'
        expect(page).to have_content('Task was successfully updated.') 
      end
    end

    context 'when user will destroy the created task' do
      #still checking why this statement deletes the task without selecting the 'Ok button' on the alert box.   
      it 'should allow the user to delete a task' do
        visit new_dashboard_task_path
        expect(page).to have_content('New Task')
 
          fill_in 'task_title', with: 'abc1'
          fill_in 'task_description', with: 'abc2'
       
        click_button 'Create Task'

        visit dashboard_tasks_path
     
        click_link 'Destroy'
        #alert box doesn't appear after clicking destroy.
        expect(page).to have_content('Task was successfully destroyed.')
       
      end
    end  
  end
end   
    #context 'when user is done creating a task' do
    #  it 'should show the task created' do
    #    visit  dashboard_tasks_path
    #    expect(page).to have_content('Listing tasks')
    #    expect(page).to have_content('Title')
    #    expect(page).to have_content('Description')
    #    expect(page).to have_content('Completed')
    #  end
 
    #  it 'should allow the user to visit edit' do
    #    click_link 'Edit'
    #    visit  dashboard_tasks_path
    #    expect(page).to have_content('Update Task')
    #    expect(page).to have_content('Listing Task')
    # end
    #end
 
    #pending 'when user will delete a task'
    #   pending  context 'when user will delete a task' do
    #    it 'should allow the user to delete a task' do
    #     expect { delete :destroy, id: dashboard_task  }
    #   end
    #    it 'should let user cancel destroying a task' do
    #     expect {}
    #   end
    # end
 
    #end