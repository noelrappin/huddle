module NavigationHelpers
  def path_to(page_name)
    case page_name
    
    when /the homepage/
      root_path
    when /the new users_and_projects page/
      new_users_and_projects_path
    when /edit page for "(.*)"/
      @project = Project.find_by_name($1)
      edit_project_path(@project)
    when /show page for "(.*)"/
      @project = Project.find_by_name($1)
      project_path(@project)
    # Add more page name => path mappings here
    
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World do |world|
  world.extend NavigationHelpers
  world
end
