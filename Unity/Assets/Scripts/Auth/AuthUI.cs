using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class AuthUI : MonoBehaviour
{
    public InputField usernamelnput;
    public InputField passwordInput;

    public Button registerButton;
    public Button loginButton;

    public Text statusText;

    private AuthManager authManager;

    // Start is called before the first frame update
    void Start()
    {
        authManager = GetComponent<AuthManager>();
        registerButton.onClick.AddListener(OnRegisterClick);
        loginButton.onClick.AddListener(OnLoginClick);
    }

    private void OnRegisterClick()
    {
        StartCoroutine(RegisterCoroutine());
    }
    private void OnLoginClick()
    {
        StartCoroutine(LoginCoroutine());
    }

    private IEnumerator LoginCoroutine()
    {
        statusText.text = "�α��� ��.....";
        yield return StartCoroutine(authManager.Login(usernamelnput.text, passwordInput.text));
        statusText.text = "�α��� ����";
    }

    private IEnumerator RegisterCoroutine()
    {
        statusText.text = "ȸ�� ���� ��.....";
        yield return StartCoroutine(authManager.Register(usernamelnput.text, passwordInput.text));
        statusText.text = "ȸ�� ���� ����! �α��� ���ּ���.";
    }
}
