# WordPress Codespace

In this repository you will find an example application to deploy, to use the so-called GitHub Codespaces. In this example, you will be able to deploy the following applications:

* MySQL Database Server
* phpMyAdmin
* WordPress

In this repository, you will find a `compose.yaml` file that will allow us to deploy the applications. To do this, we will perform the following steps:

## Steps to Set Up

1. Log in to GitHub, and go to this repository: [https://github.com/zerasul/wordpresscodepasce](https://github.com/zerasul/wordpresscodepasce)
2. Once there, we will create a "fork"; that is, a copy. To do this, click the Fork button you'll find in the upper right corner.

![image](https://github.com/user-attachments/assets/a704aa3e-3c9f-4cce-94de-cfebd380ebac)

3. After completing this, you will have a copy in your user account of this same repository; the address will be: github.com/<your-username>/wordpresscodepasce
4. Now, let's activate the codespace. This is an option that will allow us to have a complete development environment on the web; you can also run commands on a virtual machine in the cloud.
5. To activate the codespace, click the green "Code" button and look for the "Codespace" tab; once there, create a new codespace.

![image](https://github.com/user-attachments/assets/d9332acf-e92b-44fc-a25a-a1d17ba5124b)

6. Once we've entered the codespace, you can see that it's a complete Visual Studio Code environment. You can use the same functionalities as the local version.
7. Before proceeding to start the applications, let's install some extensions; to install an extension, click the fifth icon on the left and search for the "Docker" extension; once found, click the install button.

![image](https://github.com/user-attachments/assets/08f2871a-1846-404e-8913-3fae553e5cae)

8. After installing the extensions, you can now start the applications; click on the "compose.yaml" file in the codespace and select "Compose Up"; this will read the Docker Compose file and start the applications.

![image](https://github.com/user-attachments/assets/c10c8e78-cb50-4f63-bbfb-275d4427350a)

9. Once it has finished configuring and starting the containers, you can go to any service in the Docker containers tab (seventh icon on the left) and right-click on one of the containers and select "Open in web browser".

![image](https://github.com/user-attachments/assets/25a822d0-24af-4495-924a-015117e8bb33)

**NOTE:** Remember to shut down the containers and delete the codespace when finished. To do this, select the same option in Docker Compose and choose "Compose Down" and to delete the codespace from the GitHub page, select delete on that codespace.